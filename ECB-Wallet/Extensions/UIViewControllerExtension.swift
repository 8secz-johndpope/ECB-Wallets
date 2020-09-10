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
            message = "Đã tồn tại email này"
        case 202:
            message = "Không tồn tại email này"
        case 203:
            message = "Không tồn tại email này"
        case 204:
            message = "Code xác thực sai"
        case 206:
            message = "Đã tồn tại username này"
        case 207:
            message = "Không tồn tại phone code này"
        case 208:
            message = "Không tồn tại location này"
        case 209:
            message = "Mật khẩu hiện tại không chính xác (khi đổi mật khẩu)"
        case 210:
            message = "Tài khoản chưa được kích hoạt"
        case 211:
            message = "Code xác thực hết hạn ( 60 giây từ lúc gửi )"
        case 212:
            message = "Code xác thực tài khoản ko hợp lệ"
        case 213:
            message = "Ký tự không hợp lệ ( ví dụ username nhưng có số hoặc ký tự đặc biệt )"
        case 214:
            message = "Đổi mật khẩu nhưng mật khẩu mới giống mật khẩu cũ"
        case 400:
            message = "Token sai hoặc hết hạn"
        case 401:
            message = "Đăng nhập thất bại ( sai email hoặc mật khẩu )"
        case 800:
            message = "Không tồn tại api này"
        case 808:
            message = "Upload thất bại"
        case 900:
            message = "Validation"
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
