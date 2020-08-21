//
//  BoundBottomLeftAndTopRightCornerView.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/21/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
@IBDesignable
class BoundBottomLeftAndTopRightCornerView: UIView {

    @IBInspectable var radius:CGFloat = 10
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    override func awakeFromNib() {
        setup()
    }
    func setup(){
        self.roundCornerView([.layerMinXMaxYCorner, .layerMaxXMinYCorner], radius: radius)
    }

}
