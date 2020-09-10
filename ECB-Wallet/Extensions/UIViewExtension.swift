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
    //
    func bindToKeyboardView(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
}
