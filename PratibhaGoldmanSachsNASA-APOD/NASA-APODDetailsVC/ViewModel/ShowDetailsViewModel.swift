//
//  ShowDetailsViewModel.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import Foundation

struct APIRequest : APIRequestData {
    
    var headers: [String : String]? {
        return nil
    }
    var path: String {
        Constant.shared.API_PATH
    }
    var method: HTTPMethod {
        .get
    }
    var parameters: RequestParams {
        let content = ["date": CommonConfigs.shared.selctedDate,"api_key": Constant.shared.API_KEY]
        let requestParam = RequestParams.init(urlParameters: content)
        return requestParam
    }
    var dataType: ResponseDataType {
        .JSON
    }
}

class ShowDetailsViewModel {
    
    private let authManager: NetworkManagerProtocol
    let showDetailsDataModel = ShowDetailsDataModel()
    let favoriteCDModelConfig = FavoriteCDModelConfig()
    
    init(authorizationManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.authManager = authorizationManager
    }
    
    func getNasaAstronomyPictureDetails(apiRequestValue: APIRequestData = APIRequest(), completion: @escaping(NasaObjectModel?, _ errorMessage: String?) -> Void ) {
        
        showDetailsDataModel.fetch(request: apiRequestValue, auth: authManager, basePath: Constant.shared.API_BASE_PATH) { data, response in
            do {
                //Save value in UserDefault for NoNetwork condition
                UserDefaults.standard.set(data, forKey: Constant.shared.SAVE_USERDEFAULT_KEY)
                UserDefaults.standard.synchronize()
                
                let newsDataMapped = try JSONDecoder().decode(NasaObjectModel.self, from: data)
                completion(newsDataMapped, nil)
            } catch {
                print(error.localizedDescription)
            }
        } failure: { Data, respnse, error in
            print(error.getFormattedError(message: Constant.shared.NO_DATA_FOUND))
            completion(nil, Constant.shared.NO_DATA_FOUND)
        }
    }
    
    func saveFavoriteData(nasaObject: NasaObjectModel) {
        favoriteCDModelConfig.saveData(nasaObject: nasaObject)
    }
    
    func checkAPODinCoreData(date: String) -> [Favorite]? {
        let favData = favoriteCDModelConfig.getFavoriteDataByDate(date: date)
        return favData
    }
    
    func uncheckFavButton(date: String) {
        let favData = favoriteCDModelConfig.getFavoriteDataByDate(date: date)
        if let favData = favData {
            PersistentStoreContainer.shared.context.delete(favData[0])
            PersistentStoreContainer.shared.saveContext()
        }
    }
    
    func getNasaApodWhenNoNetwork() -> NasaObjectModel? {
        var nasaObjectModel: NasaObjectModel?
        if let data = UserDefaults.standard.data(forKey: Constant.shared.SAVE_USERDEFAULT_KEY) {
            do {
                nasaObjectModel = try JSONDecoder().decode(NasaObjectModel.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nasaObjectModel
    }
}
