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
        flatImage.layer.cornerRadius = 5
        flatImage.clipsToBounds = true
        flatImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //config cell
    func configCell(_ flag:flag){
        let queue = DispatchQueue(label: "handDowload")
        queue.async {
            guard let urlImage = flag.imageUrl else {return}
            let url = URL(string: urlImage)
            do{
                let dataImage = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.flatImage.image = UIImage(data: dataImage)
                }
            }catch{
                print("Can't not dowload Image from \(url)")
            }
        }
        self.imageView?.image = UIImage(named: flag.imageUrl!)
        self.countryLabel.text = "\(flag.countryName!) (+\(flag.phoneCode!))"
    }
    
}
