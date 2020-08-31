//
//  ChangePasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/29/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set textFields Delegate
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        repeatNewPasswordTextField.delegate = self
        // set isSecure for textFields
        currentPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.isSecureTextEntry = true
        repeatNewPasswordTextField.isSecureTextEntry = true
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonWasPressed(_ sender: Any) {
    }
    @IBAction func hideCurrentPasswordWasPressed(_ sender: Any) {
        if currentPasswordTextField.isSecureTextEntry == true{
            currentPasswordTextField.isSecureTextEntry = false
        }else{
            currentPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func hideNewPasswordWasPressed(_ sender: Any) {
        if newPasswordTextField.isSecureTextEntry == true{
            newPasswordTextField.isSecureTextEntry = false
        }else{
            newPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func hideRepeatNewPasswordWasPressed(_ sender: Any) {
        if repeatNewPasswordTextField.isSecureTextEntry == true{
            repeatNewPasswordTextField.isSecureTextEntry = false
        }else{
            repeatNewPasswordTextField.isSecureTextEntry = true
        }
    }
    
}
extension ChangePasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentPasswordTextField{
            newPasswordTextField.becomeFirstResponder()
        }else if textField == newPasswordTextField{
            repeatNewPasswordTextField.becomeFirstResponder()
        }else{
            repeatNewPasswordTextField.resignFirstResponder()
        }
        return true
    }
}
