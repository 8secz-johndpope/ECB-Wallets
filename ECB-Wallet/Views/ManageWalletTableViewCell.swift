//
//  ManageWalletTableViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ManageWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCurrency: UIImageView!
    @IBOutlet weak var titleCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MAke a function configure cell in here
    
    @IBAction func switchControllWasPressed(_ sender: Any) {
        
    }
}
