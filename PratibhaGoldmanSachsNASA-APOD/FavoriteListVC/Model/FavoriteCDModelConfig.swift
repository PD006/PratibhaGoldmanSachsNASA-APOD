//
//  FavoriteCDModelConfig.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation
import CoreData

class FavoriteCDModelConfig {
    
    func saveData(nasaObject: NasaObjectModel) {
        let favoriteCD = Favorite(context: PersistentStoreContainer.shared.context)
        favoriteCD.title = nasaObject.title
        favoriteCD.explanation = nasaObject.explanation
        favoriteCD.date = nasaObject.date
        favoriteCD.mediaURL = nasaObject.mediaURL
        
        let mediaType = nasaObject.media_type
        switch mediaType {
        case .image:
            favoriteCD.media_type = "image"
        case .video:
            favoriteCD.media_type = "video"
        default:
            favoriteCD.media_type = "other"
        }
        
        PersistentStoreContainer.shared.saveContext()
    }
    
    func getFavoriteData() -> [Favorite]? {
        do {
            let favData = try PersistentStoreContainer.shared.context.fetch(Favorite.fetchRequest())
            return favData
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getFavoriteDataByDate(date: String) -> [Favorite]? {
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        let predicate = NSPredicate(format: "date == %@", date)
        fetchRequest.predicate = predicate
        var favData: [Favorite]?
        
        do {
            favData = try PersistentStoreContainer.shared.context.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
        }
        return favData
    }
    
    func deleteSelectedFavoriteData(index: Int) -> Bool {
        let favList = getFavoriteData()
        
        if let favList = favList {
            PersistentStoreContainer.shared.context.delete(favList[index])
            PersistentStoreContainer.shared.saveContext()
            return true
        }
        return false
    }
}
