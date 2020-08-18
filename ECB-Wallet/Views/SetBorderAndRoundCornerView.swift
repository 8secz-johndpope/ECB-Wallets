//
//  SetBorderAndRoundCornerView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/18/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class SetBorderAndRoundCornerView: UIView {
    @IBInspectable var radious:CGFloat = 5.0
    @IBInspectable var borderWidth:CGFloat = 1.0
    @IBInspectable var borderColor:UIColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
    override func prepareForInterfaceBuilder() {
        setup()
    }
    override func awakeFromNib() {
        setup()
    }
    func setup(){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
        //
        self.layer.shadowColor = borderColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = radious
        self.layer.masksToBounds = false
    }
}
