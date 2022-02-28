//
//  FavoriteListViewController+Extension.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation
import UIKit

extension FavoriteListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteDataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.shared.FAVORITE_LIST_TABLEVIEW_CELL_IDENTIFIER, for: indexPath) as? FavoriteListTableViewCell else {
            return UITableViewCell()
        }
        
        guard let favoriteDataList =  favoriteDataList else {
            return UITableViewCell()
        }
        favTableViewCell.titleLabel.text = favoriteDataList[indexPath.row].title
        
        if let url = URL(string: favoriteDataList[indexPath.row].mediaURL!) {
            favTableViewCell.nasaImageView.isHidden = false
            favTableViewCell.nasaImageView.loadImageWithUrl(url)
        }
        
        return favTableViewCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235.0
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if favoriteListViewModel.deleteSelectedFav(index: indexPath.row) {
                favoriteDataList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                configUI()
            }
        }
    }
}
