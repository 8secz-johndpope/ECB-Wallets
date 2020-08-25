//
//  RoundCornerView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/18/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class RoundCornerView: UIView {

    @IBInspectable var radius:CGFloat = 10.0
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.roundCornerView([.layerMaxXMinYCorner,.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: radius)
        self.clipsToBounds = true
    }

}

