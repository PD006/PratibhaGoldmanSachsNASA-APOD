//
//  ShowDetailsViewController+Extension.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 27/02/22.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

extension ShowDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nasaObjectModel != nil {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.shared.SHOW_DETAILS_TABLEVIEW_CELL_IDENTIFIER, for: indexPath) as? ShowDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        if let nasaObjectModel = nasaObjectModel {
            tableViewCell.nasaTitleLabel.text = nasaObjectModel.title
            tableViewCell.detailLabel.text = nasaObjectModel.explanation
            
            //////*******Checking Media Type***********
            if nasaObjectModel.media_type == .image {
                if let url = URL(string: nasaObjectModel.mediaURL) {
                    tableViewCell.mediaImageView.isHidden = false
                    tableViewCell.mediaImageView.loadImageWithUrl(url)
                    self.hideIndicator()
                }
            } else if nasaObjectModel.media_type == .video {
                if let url = URL(string: nasaObjectModel.mediaURL) {
                    self.hideIndicator()
                    tableViewCell.mediaImageView.isHidden = true
                    
                    let avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
                    let avpController = AVPlayerViewController()
                    avpController.player = avPlayer
                    avpController.view.frame.size.height = tableViewCell.containerView.frame.size.height
                    avpController.view.frame.size.width = tableViewCell.containerView.frame.size.width
                    tableViewCell.containerView.addSubview(avpController.view)
                    avPlayer.play()
                }
            }
        }
        return tableViewCell
    }
}
