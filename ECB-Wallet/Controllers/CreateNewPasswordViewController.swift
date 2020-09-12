//
//  CreateNewPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswodTextField: UITextField!
    //
    var spinerView:UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spiner.style = .whiteLarge
        spiner.startAnimating()
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    //
    var email = ""
    var code = ""
    var isErrorValadate:Bool?
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.keyboardType = .numberPad
        repeatNewPasswodTextField.isSecureTextEntry = true
        repeatNewPasswodTextField.keyboardType = .numberPad
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
    //MARK: - UI Events
    @IBAction func createButtonWasPressed(_ sender: Any) {
        //
        self.view.endEditing(true)
        //Step1 valadate user input
        guard let password = newPasswordTextField.text else {return}
        guard let passwordConfirm = repeatNewPasswodTextField.text else {return}
        if password.isValadatePasswprd(){
            isErrorValadate = false
            if passwordConfirm == password{
                isErrorValadate = false
            }else{
                isErrorValadate = true
                self.showToast(message: NSLocalizedString("validate_repeat_password_key", comment: "validate_repeat_password"))
            }
        }else{
            isErrorValadate = true
            self.showToast(message: NSLocalizedString("validate_password_key", comment: "validate_password"))
        }
        //
        //Step2 Send data to API
        if isErrorValadate == false{
            //show spiner
            self.showSpiner()
            //Call to API
            AuthService.instan.resetPassword(email: email, code: code, password: password, passwordConfirm: passwordConfirm) { (success, errorCode) in
                if success {
                    if errorCode == 0 {
                        self.spinerView.stopAnimating()
                        self.performSegue(withIdentifier: "goToFinishSignUpVC", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("Cant reset password")
                }
            }
        }
    }
    //MARK: - Helper Method
    //Show spiner
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    //MARK: - UI NavigationCotroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinishSignUpVC"{
            let destVC = segue.destination as! FinishSignUpViewController
            destVC.content = "You have successfully changed your password"
        }
    }
}
