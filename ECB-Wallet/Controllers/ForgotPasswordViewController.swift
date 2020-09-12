//
//  ForgotPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    //MARK: Ui Elements
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    //
    var spinerView:UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spiner.style = .whiteLarge
        spiner.startAnimating()
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    //MARK: UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func submitButtonWasPressed(_ sender: Any) {
        self.view.endEditing(true)
        guard let email = emailTextField.text else {return}
        if email.isValadateEmail(){
            //Show spiner
            self.showSpiner()
            // Send data to API to get code
            AuthService.instan.requestCode(email: email) { (success, errorCode) in
                if success{
                    if errorCode == 0 {
                        self.spinerView.stopAnimating()
                        self.performSegue(withIdentifier: "goToVerifyForgotPasswordVC", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("Cant not request code from API")
                }
            }
        }else{
            self.showToast(message: NSLocalizedString("validate_email_key", comment: "validate_email"))
        }
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - UI NavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVerifyForgotPasswordVC"{
            let dest = segue.destination as! VerifyForgotPasswordViewController
            guard let email = emailTextField.text else {return}
            dest.email = email
        }
    }
    //MARK: Helper Method
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    


}
