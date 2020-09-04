//
//  SelectPaymentTableViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/4/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SelectPaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var methodName: UILabel!
    @IBOutlet weak var circleView: BoundFourCornersView!
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView.layer.borderWidth = 1
        circleView.layer.borderColor = UIColor.lightGray.cgColor
        circleView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
