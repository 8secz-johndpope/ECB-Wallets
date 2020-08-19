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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // set textField Delegate
        userNameTextField.delegate = self
        emailTextField.delegate = self
        phoneCodeTextField.delegate = self
        passwordTextfield.delegate = self
        repeatPasswordTextField.delegate = self
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    //MARK: - UI events
    @IBAction func phoneCodeButtonWasPressed(_ sender: Any) {
    }
    @IBAction func checkButtonWasPressed(_ sender: Any) {
    }
    @IBAction func termAndConditionButtonWasPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonWasPressed(_ sender: Any) {
    }
    @IBAction func signInbuttonWasPressed(_ sender: Any) {
    }
    //MARK: - Helper methods
    @objc func keyboardWillShow(notification:NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.size.height)
    }
    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentOffset = .zero
    }
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
