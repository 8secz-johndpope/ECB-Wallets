//
//  SignUpViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: - UI elements
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneCodeButton: UIButton!
    @IBOutlet weak var phoneCodeLabel: UILabel!
    @IBOutlet weak var phoneCodeTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup keyboard events
        scrollView.bindToKeyboard()
        // set textField Delegate
        userNameTextField.delegate = self
        emailTextField.delegate = self
        phoneCodeTextField.delegate = self
        passwordTextfield.delegate = self
        repeatPasswordTextField.delegate = self
        passwordTextfield.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    //MARK: - UI events
    @IBAction func phoneCodeButtonWasPressed(_ sender: Any) {
    }
    @IBAction func hidePasswordButtonWasPressed(_ sender: Any) {
        if passwordTextfield.isSecureTextEntry{
            passwordTextfield.isSecureTextEntry = false
        }else{
            passwordTextfield.isSecureTextEntry = true
        }
    }
    @IBAction func hideRepeatPasswordButtonWasPressed(_ sender: Any) {
        if repeatPasswordTextField.isSecureTextEntry{
            repeatPasswordTextField.isSecureTextEntry = false
        }else{
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func checkButtonWasPressed(_ sender: Any) {
    }
    @IBAction func termAndConditionButtonWasPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToVerifyAccountView", sender: nil)
    }
    @IBAction func signInbuttonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoSignInVC", sender: nil)
    }
    //MARK: - Helper methods
    @objc func handleTapToHideKeyboard(){
        self.view.endEditing(true)
    }
}
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField{
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            phoneCodeTextField.becomeFirstResponder()
        }else if textField == phoneCodeTextField{
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield{
            repeatPasswordTextField.becomeFirstResponder()
        }else{
            repeatPasswordTextField.resignFirstResponder()
        }
        return true
    }
}
