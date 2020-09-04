//
//  SignInViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/18/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    //MARK: - UI elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - UI viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup keyboard events
        scrollView.bindToKeyboard()
        // set textField delegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    //MARK: - UI events
    @IBAction func hidePasswordButtonWasPressed(_ sender: Any) {
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        print("Sign In")
        self.performSegue(withIdentifier: "goToDashBoardVC", sender: nil)
    }
    @IBAction func forgetPasswordButtonWasPressed(_ sender: Any) {
        print("forget password")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "forgotPasswordVC")
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func signUpButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSignUpVC", sender: nil)
    }
    //MARK: - UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    //MARK: Helper method
    @objc func handleTapToHideKeyboard() {
        self.view.endEditing(true)
    }
    
}
