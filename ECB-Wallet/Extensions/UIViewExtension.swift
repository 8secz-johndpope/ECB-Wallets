//
//  UIViewExtension.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/25/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func roundCornerView(_ cornes: CACornerMask, radius: CGFloat){
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = cornes
        }
    }
}
