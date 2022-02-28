//
//  FavoriteListViewModel.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation

class FavoriteListViewModel {
    
    let favoriteCDModelConfig = FavoriteCDModelConfig()
    
    func getFavoriteList() -> [Favorite]? {
        if let favoriteList = favoriteCDModelConfig.getFavoriteData() {
            return favoriteList
        }
        return nil
    }
    
    func deleteSelectedFav(index: Int) -> Bool {
        return favoriteCDModelConfig.deleteSelectedFavoriteData(index: index)
    }
    
    func getNasaObjectFromFavorite(favoriteDataList: Favorite) -> NasaObjectModel {
        var mediaType : MediaType?
        if favoriteDataList.media_type == "image" {
            mediaType = MediaType(rawValue: "image")
        } else if favoriteDataList.media_type == "video" {
            mediaType = MediaType(rawValue: "video")
        } else {
            mediaType = MediaType(rawValue: "other")
        }
        
        let nasaObjectModel = NasaObjectModel(date: favoriteDataList.date, explanation: favoriteDataList.explanation, media_type: mediaType, title: favoriteDataList.title ?? "", mediaURL: favoriteDataList.mediaURL ?? "")
        
        return nasaObjectModel
    }
}
