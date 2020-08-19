//
//  BoundFourCornersView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class BoundFourCornersView: UIView {
    @IBInspectable var radius:CGFloat = 5.0
    override func prepareForInterfaceBuilder() {
        setup()
    }
    override func awakeFromNib() {
        setup()
    }
    func setup(){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}
