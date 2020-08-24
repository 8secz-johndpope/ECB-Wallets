//
//  AddressWalletTableViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class AddressWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var ownerWalletLabel: UILabel!
    @IBOutlet weak var addressWalletLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
