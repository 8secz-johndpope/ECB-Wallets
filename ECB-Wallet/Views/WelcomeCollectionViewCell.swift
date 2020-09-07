//
//  WelcomeCollectionViewCell.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/17/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configureCell(with page:introductionModel){
        let queue = DispatchQueue(label: "dowloadImage")
        queue.async {
            guard let urlImage = page.imageUrl else {return}
            let url = URL(string: urlImage)
            do{
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }catch{
                print("Can't not download image from \(url)")
            }
        }
        self.titleLabel.text = page.title
        self.subTitleLabel.text = page.subtitle
        self.contentLabel.text = page.content
    }

}
