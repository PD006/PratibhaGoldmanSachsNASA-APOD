//
//  favoriteListViewController.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import UIKit

class FavoriteListViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var favListTableView: UITableView!
    @IBOutlet weak var noFavListLabel: UILabel!
    
    //MARK: - Variable
    var favoriteDataList: [Favorite]?
    var favoriteListViewModel = FavoriteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteDataList = favoriteListViewModel.getFavoriteList()
        configUI()
    }
    
    func configUI() {
        if (favoriteDataList?.count ?? 0) != 0 {
            noFavListLabel.isHidden = true
            favListTableView.isHidden = false
        } else {
            noFavListLabel.isHidden = false
            favListTableView.isHidden = true
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

