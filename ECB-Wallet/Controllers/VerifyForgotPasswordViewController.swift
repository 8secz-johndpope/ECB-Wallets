//
//  VerifyForgotPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class VerifyForgotPasswordViewController: UIViewController {
    //MARK: UI Elements
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var expriedLabel: UILabel!
    @IBOutlet weak var OTPTextfield1: UITextField!
    @IBOutlet weak var OTPTextField2: UITextField!
    @IBOutlet weak var OTPTextField3: UITextField!
    @IBOutlet weak var OTPTextField4: UITextField!
    @IBOutlet weak var OTPTextField5: UITextField!
    @IBOutlet weak var OTPTextField6: UITextField!
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
    var expriedTimer:Timer?
    var counter = 60
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up expriedTimer
        expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
        // set textField Delegate
        OTPTextfield1.delegate = self
        OTPTextField2.delegate = self
        OTPTextField3.delegate = self
        OTPTextField4.delegate = self
        OTPTextField5.delegate = self
        OTPTextField6.delegate = self
        //
        OTPTextfield1.keyboardType = .numberPad
        OTPTextField2.keyboardType = .numberPad
        OTPTextField3.keyboardType = .numberPad
        OTPTextField4.keyboardType = .numberPad
        OTPTextField5.keyboardType = .numberPad
        OTPTextField6.keyboardType = .numberPad
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
    
    //MARK: UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonwasPressed(_ sender: Any) {
        //
        self.view.endEditing(true)
        if counter == 0 {
            self.showAlert(message: "OTP is over time, please press 'Resend OTP' button")
        }else{
            let OTP = "\(OTPTextfield1.text!)\(OTPTextField2.text!)\(OTPTextField3.text!)\(OTPTextField4.text!)\(OTPTextField5.text!)\(OTPTextField6.text!)"
            code = OTP
            
            //Show spiner
            self.showSpiner()
            // Sent data to API
            AuthService.instan.verifyCodeForgotPassword(code: OTP, email: email) { (success, errorCode) in
                if success{
                    if errorCode == 0 {
                        self.spinerView.stopAnimating()
                        self.performSegue(withIdentifier: "goToCreateNewPasswordVC", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("cant verify code")
                }
            }
        }
        
    }
    @IBAction func resendOTPButtonWasPressed(_ sender: Any) {
        //Step 1 call back timer
        counter = 60
        if expriedTimer!.isValid{
            expriedTimer?.invalidate()
            expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
        }else{
            expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
        }
        //Step 2 send data to API to request send OTP again
        AuthService.instan.requestCode(email: email) { (success, errorCode) in
            if success{
                if errorCode != 0 {
                    self.showAlert(errorCode: errorCode!)
                }
            }else{
                print("cant request to resend OTP")
            }
        }
    }
    //MARK: - UI NavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCreateNewPasswordVC"{
            let dest = segue.destination as! CreateNewPasswordViewController
            dest.email = email
            dest.code = code
        }
    }
    //MARK: Helper Method
    //handle ExpriedTimer
    @objc func handleExpriedTimer(){
        counter -= 1
        if counter >= 0 {
            self.expriedLabel.text = "Expried in \(counter)s"
            //self.confirmButton.isEnabled = true
        }else if counter < 0{
            //self.showAlert(message: "OTP is over time, please press 'Resend OTP' button")
            expriedTimer?.invalidate()
            counter = 0
            //self.confirmButton.isEnabled = false
        }
    }
    //Show Alert
    func showAlert(message:String){
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: UIAlertController.Style.alert)
        let btn_OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(btn_OK)
        self.present(alert, animated: true, completion: nil)
    }
    //Show spiner
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
//MARK: - UITextFieldDelegate
extension VerifyForgotPasswordViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count < 1 && string.count > 0{
            if textField == OTPTextfield1{
                OTPTextField2.text = ""
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextField2{
                OTPTextField3.text = ""
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextField4.text = ""
                OTPTextField4.becomeFirstResponder()
            }
            if textField == OTPTextField4{
                OTPTextField5.text = ""
                OTPTextField5.becomeFirstResponder()
            }
            if textField == OTPTextField5{
                OTPTextField6.text = ""
                OTPTextField6.becomeFirstResponder()
            }
            if textField == OTPTextField6{
                OTPTextField6.resignFirstResponder()
            }
            textField.text = string
            return false
        }else if textField.text!.count >= 1 && string.count == 0 {
            if textField == OTPTextField2{
                OTPTextfield1.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextField4{
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField5{
                OTPTextField4.becomeFirstResponder()
            }
            if textField == OTPTextField6{
                OTPTextField5.becomeFirstResponder()
            }
            if textField == OTPTextfield1{
                OTPTextfield1.resignFirstResponder()
            }
            textField.text = "-"
            return false
        }else if textField.text!.count >= 1{
            if textField == OTPTextfield1{
                OTPTextField2.text = ""
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextField2{
                OTPTextField3.text = ""
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextField4.text = ""
                OTPTextField4.becomeFirstResponder()
            }
            if textField == OTPTextField4{
                OTPTextField5.text = ""
                OTPTextField5.becomeFirstResponder()
            }
            if textField == OTPTextField5{
                OTPTextField6.text = ""
                OTPTextField6.becomeFirstResponder()
            }
            if textField == OTPTextField6{
                OTPTextField6.resignFirstResponder()
            }
            textField.text = string
            return false
        }
        return true
    }
}

