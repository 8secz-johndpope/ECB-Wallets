//
//  ListFlatTableViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/7/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ListFlatTableViewCell: UITableViewCell {

    @IBOutlet weak var flatImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var isCheckImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //config cell
    func configCell(_ flat:flat){
        self.imageView?.image = UIImage(named: flat.imageUrl!)
        self.countryLabel.text = flat.countryName
    }
    
}
