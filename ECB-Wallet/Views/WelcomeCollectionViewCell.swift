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
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configureCell(with page:Page){
        self.imageView.image = UIImage(named: page.image)
        self.titleLabel.text = page.title
        self.contentLabel.text = page.content
    }

}
