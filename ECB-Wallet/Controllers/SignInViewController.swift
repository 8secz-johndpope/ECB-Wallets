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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // set textField delegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    //MARK: - UI events
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
        print("sign up")
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
    @objc func handleTapToHideKeyboard() {
        self.view.endEditing(true)
    }
    
}
