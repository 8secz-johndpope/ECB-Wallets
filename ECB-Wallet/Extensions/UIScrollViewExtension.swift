//
//  UIScrollViewExtension.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/26/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import UIKit
extension UIScrollView{
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: Helper method
    @objc func keyboardWillShow(notification:NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        self.contentOffset = CGPoint(x: 0, y: keyboardFrame.size.height)
    }
    @objc func keyboardWillHide(notification:NSNotification){
        self.contentOffset = .zero
    }
    
}
