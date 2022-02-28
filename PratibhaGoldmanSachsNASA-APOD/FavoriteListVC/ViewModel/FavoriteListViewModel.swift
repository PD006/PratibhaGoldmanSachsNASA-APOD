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
}
