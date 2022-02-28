//
//  ShowDetailsViewController.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var detailsTableView: UITableView!
    
    //MARK: - Variables
    private let showDetailsViewModel = ShowDetailsViewModel()
    var nasaObjectModel: NasaObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Update UI
        configUI()
        
        //MARK: - Get NASA Astronomy Details
        if nasaObjectModel == nil {
            fetchingAstronomyPicture()
        } else {
            favButtonConfig()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        if !favButton.isSelected {
            if let nasaObjectModel = nasaObjectModel {
                showDetailsViewModel.saveFavoriteData(nasaObject: nasaObjectModel)
            }
            favButton.isSelected = true
            favButton.setImage(UIImage(named: "heartRed"), for: .normal)
        }
        else {
            if let nasaObjectModelDate = nasaObjectModel?.date {
                showDetailsViewModel.uncheckFavButton(date: nasaObjectModelDate)
            }
            favButton.isSelected = false
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    //MARK: - Manage UI
    func favButtonConfig() {
        let favData = showDetailsViewModel.checkAPODinCoreData(date: nasaObjectModel?.date ?? "")
        if (favData?.count ?? 0) > 0 {
            favButton.isSelected = true
            favButton.setImage(UIImage(named: "heartRed"), for: .normal)
        } else {
            favButton.isSelected = false
            favButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    func configUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = true
        dateLabel.text = CommonConfigs.shared.selctedDate
    }
    
    //MARK: - Fetching data from server
    
    func fetchingAstronomyPicture() {
        if Reachability.isConnectedToNetwork() {
            showIndicator()
            showDetailsViewModel.getNasaAstronomyPictureDetails { nasaDetailsModel, errorMessage  in
                if nasaDetailsModel != nil {
                    self.nasaObjectModel = nasaDetailsModel
                    DispatchQueue.main.async {
                        self.favButtonConfig()
                        self.detailsTableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.hideIndicator()
                        self.showAlert(title: "Alert", message: errorMessage ?? "No data found.")
                    }
                }
            }
        } else {
            self.nasaObjectModel = showDetailsViewModel.getNasaApodWhenNoNetwork()
            if nasaObjectModel != nil {
                dateLabel.text = nasaObjectModel?.date
                self.favButtonConfig()
                self.detailsTableView.reloadData()
            }
            self.showAlert(title: Constant.shared.NO_INTERNET_CONNECTION_TITLE, message: Constant.shared.NO_INTERNET_CONNECTION_MESSAGE)
        }
    }
}
