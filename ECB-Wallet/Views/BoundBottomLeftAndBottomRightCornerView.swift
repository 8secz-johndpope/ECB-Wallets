//
//  BoundBottomLeftAndBottomRightCornerView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class BoundBottomLeftAndBottomRightCornerView: UIView {

    @IBInspectable var radius:CGFloat = 10.0
    override func prepareForInterfaceBuilder() {
        setup()
    }
    override func awakeFromNib() {
        setup()
    }
    func setup(){
        self.roundCornerView([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radius)
        self.clipsToBounds = true
    }

}
