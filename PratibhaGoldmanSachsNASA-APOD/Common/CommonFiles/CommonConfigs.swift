//
//  MBProgressHubConfig.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation
import MBProgressHUD
import UIKit

class CommonConfigs {
    
    static let shared = CommonConfigs()
    private init() {}
    
    var selctedDate = Date().today()
}
    

//MARK: - UIViewController Extension
extension UIViewController {
    
    //Manage MBProgress Hub
    func showIndicator() {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
    }
    
    func hideIndicator() {
       MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //Showing UIAlert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Date format
extension Date {
    func today(format : String = "YYYY-MM-dd", date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

// MARK: - Saving images in NSCache
var imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageURL: URL?
    
    func loadImageWithUrl(_ url: URL) {
        imageURL = url
        self.image = nil
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            })
        }).resume()
    }
}
