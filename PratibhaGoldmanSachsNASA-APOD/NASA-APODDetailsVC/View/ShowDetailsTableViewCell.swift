//
//  ShowDetailsTableViewCell.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import UIKit

class ShowDetailsTableViewCell: UITableViewCell {

    //MARK: - Outlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nasaTitleLabel: UILabel!
    @IBOutlet weak var mediaImageView: CustomImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mediaImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
