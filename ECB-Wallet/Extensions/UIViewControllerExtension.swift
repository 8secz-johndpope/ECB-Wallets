//
//  UIViewControllerExtension.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/9/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func showToast(message:String){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height - 100 , width: 200, height: 45))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    func showAlert(errorCode:Int){
        var message = ""
        switch errorCode {
        case 201:
            message = NSLocalizedString("error_code_201_key", comment: "The email has already exist.")
        case 202:
            message = NSLocalizedString("error_code_202_key", comment: "The email does not exist.")
        case 203:
            message = NSLocalizedString("error_code_203_key", comment: "The phone number has already exist.")
        case 204:
            message = NSLocalizedString("error_code_204_key", comment: "Verify code is incorrect.")
        case 205:
        message = NSLocalizedString("error_code_205_key", comment: "The OTP is incorrect or expired.")
        case 207:
            message = NSLocalizedString("error_code_207_key", comment: "The phone code doest not exist.")
        case 208:
            message = NSLocalizedString("error_code_208_key", comment: "The location doest not exist.")
        case 209:
            message = NSLocalizedString("error_code_209_key", comment: "The current password is incorrect.")
        case 210:
            message = NSLocalizedString("error_code_210_key", comment: "Account has not active")
        case 211:
            message = NSLocalizedString("error_code_211_key", comment: "Verify account code has expired.")
        case 212:
            message = NSLocalizedString("error_code_212_key", comment: "The verify code is incorrect.")
        case 213:
            message = NSLocalizedString("error_code_213_key", comment: "Invalid character")
        case 214:
            message = NSLocalizedString("error_code_214_key", comment: "The new password must be different from current password")
        case 400:
            message = NSLocalizedString("error_code_400_key", comment: "Token is expired.")
        case 401:
            message = NSLocalizedString("error_code_401_key", comment: "User name or password is incorrect.")
        case 800:
            message = NSLocalizedString("error_code_800_key", comment: "The API does not exist.")
        case 808:
            message = NSLocalizedString("error_code_808_key", comment: "Upload fail.")
        case 900:
            message = NSLocalizedString("error_code_900_key", comment: "Validation error.")
        default:
            return
        }
        //
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: UIAlertController.Style.alert)
        let btn_OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(btn_OK)
        self.present(alert, animated: true, completion: nil)
    }
    func showSpiner(option:Bool){
        var spinerView:UIActivityIndicatorView = {
            let spiner = UIActivityIndicatorView()
            spiner.backgroundColor = UIColor(white: 0, alpha: 0.7)
            spiner.style = .whiteLarge
            spiner.startAnimating()
            spiner.translatesAutoresizingMaskIntoConstraints = false
            return spiner
        }()
        if option{
            self.view.addSubview(spinerView)
            spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }else{
            spinerView.stopAnimating()
        }
    }
}
