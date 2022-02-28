//
//  ConstantFile.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation

class Constant {
    static let shared = Constant()
    private init() {}
    
    //MARK: - Identifiers constant
    let SHOW_DETAILS_VC_IDENTIFIER = "ShowDetailsViewController"
    let FAVORITE_LIST_VC_IDENTIFIER = "FavoriteListViewController"
    let SHOW_DETAILS_TABLEVIEW_CELL_IDENTIFIER = "ShowDetailsTableViewCell"
    let FAVORITE_LIST_TABLEVIEW_CELL_IDENTIFIER = "FavoriteListTableViewCell"
    
    //MARK: - String Constant
    let NO_INTERNET_CONNECTION_TITLE = "No Internet Connection"
    let NO_INTERNET_CONNECTION_MESSAGE = "We are unable to load selected data and showing last loaded data. To get selected date's details, Please turn on WiFi or Mobile network"
    let SAVE_USERDEFAULT_KEY = "NASA_APOD"
    
    //MARK: - Network call COnstant
    let API_PATH = "planetary/apod"
    let API_KEY = "6iHSBZBXFTSJjofmrcSKK9lwrAIwjjTI6AhP1zaM"
    let API_BASE_PATH = "https://api.nasa.gov/"
    let NO_DATA_FOUND = "No data available for the selected date"
}
