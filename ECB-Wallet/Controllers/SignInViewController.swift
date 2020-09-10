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
        //
        print(driveToken)
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
    override func viewDidAppear(_ animated: Bool) {
        //Check internet are available
        if CheckInternet.Connection(){
            print("Internet is available")
        }else{
            //Show dialogVC
            let diglogVC = DialogViewController()
            diglogVC.modalPresentationStyle = .custom
            present(diglogVC, animated: true, completion: nil)
        }
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
        self.performSegue(withIdentifier: "gotoForgotPasswordVC", sender: nil)
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
