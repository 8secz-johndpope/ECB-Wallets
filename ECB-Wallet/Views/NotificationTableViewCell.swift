//
//  NotificationTableViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var containerView: BoundFourCornersView!
    @IBOutlet weak var trailingCellConstant: NSLayoutConstraint!
    @IBOutlet weak var leadingCellConstant: NSLayoutConstraint!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var notificationContentLabel: UILabel!
    @IBOutlet weak var unreadImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func hideButtonWasPressed(_ sender: Any) {
    }
    //Write a function to configure Cell in here
}
