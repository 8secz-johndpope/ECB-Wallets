//
//  ChangeColorImageView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/18/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class ChangeColorImageView: UIImageView {

    @IBInspectable var color:UIColor = UIColor(red: 46/255, green: 31/255, blue: 84/255, alpha: 1)
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.setImageColor(color: color)
    }

}
extension UIImageView {
    func setImageColor(color:UIColor){
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
