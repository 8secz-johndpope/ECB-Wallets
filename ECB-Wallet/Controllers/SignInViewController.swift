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
    @IBOutlet weak var rememberMeButton: setBorderAndRoundCornerButton!
    var isCheckRemember = false
    var isErrorValidate:Bool?
    //
    var spinerView:UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spiner.style = .whiteLarge
        spiner.startAnimating()
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    //MARK: - UI viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup keyboard events
        scrollView.bindToKeyboard()
        // set textField delegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .numberPad
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
    @IBAction func rememberMeButtonWasPressed(_ sender: Any) {
        if isCheckRemember == false{
            rememberMeButton.setBackgroundImage(UIImage(named: "checkButton"), for: UIControl.State.normal)
            isCheckRemember = true
        }else{
            rememberMeButton.setBackgroundImage(UIImage(named: ""), for: UIControl.State.normal)
            isCheckRemember = false
        }
    }
    @IBAction func hidePasswordButtonWasPressed(_ sender: Any) {
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        self.view.endEditing(true)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        //Step1: Validate user input
        if email.isValadateEmail(){
            isErrorValidate = false
            if password.isValadatePasswprd(){
                isErrorValidate = false
            }else{
                isErrorValidate = true
                self.showToast(message: "Enter your password")
            }
        }else{
            isErrorValidate = true
            self.showToast(message: "Email is not correct format")
        }
        //Step2: Send data to API to login
        if isErrorValidate == false{
            //Show spiner
            self.showSpiner()
            //
            AuthService.instan.login(firebaseToken: driveToken, password: password, email: email) { (success, errorCode) in
                if success {
                    if errorCode == 0 {
                        self.spinerView.stopAnimating()
                        defaults.set(self.isCheckRemember, forKey: REMEMBER_ME_KEY)
                        self.performSegue(withIdentifier: "goToDashBoardVC", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("Can't no login")
                }
            }
        }
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
    //Show spiner
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
