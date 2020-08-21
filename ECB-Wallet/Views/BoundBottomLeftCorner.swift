//
//  BoundBottomLeftCorner.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class BoundBottomLeftCorner: UIView {

    @IBInspectable var radius:CGFloat = 10
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    override func awakeFromNib() {
        setup()
    }
    func setup(){
        self.roundCornerView([.layerMinXMaxYCorner], radius: radius)
    }
}
