//
//  VerifyAccountViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class VerifyAccountViewController: UIViewController {
    //MARK: - UI Element
    @IBOutlet weak var OTPTextField1: UITextField!
    @IBOutlet weak var OTPTextField2: UITextField!
    @IBOutlet weak var OTPTextField3: UITextField!
    @IBOutlet weak var OTPTextfield4: UITextField!
    @IBOutlet weak var OTPTextField5: UITextField!
    @IBOutlet weak var OTPTextField6: UITextField!
    @IBOutlet weak var expriedLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var resendOTPButton: UIButton!
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
    var counter = 60
    var expriedTimer: Timer?
    var expriedTimer2: Timer?
    //
    var password = ""
    var repeatPassword = ""
    var email = ""
    var phonCode = ""
    var phoneNumber = ""
    var fullName = ""
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // set textField Delegate
        OTPTextField1.delegate = self
        OTPTextField2.delegate = self
        OTPTextField3.delegate = self
        OTPTextfield4.delegate = self
        OTPTextField5.delegate = self
        OTPTextField6.delegate = self
        //
        OTPTextField1.keyboardType = .numberPad
        OTPTextField2.keyboardType = .numberPad
        OTPTextField3.keyboardType = .numberPad
        OTPTextfield4.keyboardType = .numberPad
        OTPTextField5.keyboardType = .numberPad
        OTPTextField6.keyboardType = .numberPad
        //Obser
        NotificationCenter.default.addObserver(self, selector: #selector(messageCodeFromNotifDidChange(_:)), name: NOTIF_MESSAGE_CODE_DATA_DID_CHANGE, object: nil)
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
        //Set timer for Expried OTP
        expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
    }
    //MARK: - UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
        self.view.endEditing(true)
        let OTP = "\(OTPTextField1.text!)\(OTPTextField2.text!)\(OTPTextField3.text!)\(OTPTextfield4.text!)\(OTPTextField5.text!)\(OTPTextField6.text!)"
        
        if counter == 0 {
            self.showAlert(message: "OTP is over time, please press 'Resend OTP' button")
        }else{
            //Show spiner
            self.showSpiner()
            //Send data to API to confirm your account
            AuthService.instan.confirmAccount(username: fullName, password: password, password_confirm: repeatPassword, email: email, phoneCode: phonCode, phoneNumber: phoneNumber, code: OTP) { (success, errorCode) in
                if success{
                    if errorCode == 0{
                        self.spinerView.stopAnimating()
                        self.performSegue(withIdentifier: "goToFinishSignUpVC", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("Cant confirm password")
                }
            }
        }
    }
    @IBAction func resendOPTButtonWasPressed(_ sender: Any) {
        //Step1: call back timer
        counter = 60
        if expriedTimer!.isValid{
            expriedTimer?.invalidate()
            expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
        }else{
            expriedTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleExpriedTimer), userInfo: nil, repeats: true)
        }
        
        //Step2: send data to API to resend OTP
        AuthService.instan.resendConfirmCode(firebase_Token: driveToken, email: email) { (success, errorCode) in
            if success{
                if errorCode != 0 {
                    self.showAlert(errorCode: errorCode!)
                }
            }else{
                print("Fail to resend OTP")
            }
        }
    }
    //MARK: - Helper Method
    @objc func messageCodeFromNotifDidChange(_ notif:Notification){
        if messageCodeFromNotif != nil {
            //Fill out OTP textField automaticaly
            print("Hay tu dien vao")
            let stringCode = String(messageCodeFromNotif!)
            let codeArray = Array(stringCode)
            self.OTPTextField1.text = String(codeArray[0])
            self.OTPTextField2.text = String(codeArray[1])
            self.OTPTextField3.text = String(codeArray[2])
            self.OTPTextfield4.text = String(codeArray[3])
            self.OTPTextField5.text = String(codeArray[4])
            self.OTPTextField6.text = String(codeArray[5])
        }else{
            print("Dien tay nha ban")
        }
    }
    //handle ExpriedTimer
    @objc func handleExpriedTimer(){
        counter -= 1
        if counter >= 0 {
            self.expriedLabel.text = "Expried in \(counter)s"
            self.resendOTPButton.isEnabled = false
        }else if counter < 0{
            expriedTimer?.invalidate()
            self.resendOTPButton.isEnabled = true
            counter = 0
        }
    }
    //Show Alert
    func showAlert(message:String){
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: UIAlertController.Style.alert)
        let btn_OK = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(btn_OK)
        self.present(alert, animated: true, completion: nil)
    }
    //Show spinner
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
//MARK: UITextFieldDelegate
extension VerifyAccountViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count < 1 && string.count > 0{
            if textField == OTPTextField1{
                OTPTextField2.text = ""
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextField2{
                OTPTextField3.text = ""
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextfield4.text = ""
                OTPTextfield4.becomeFirstResponder()
            }
            if textField == OTPTextfield4{
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
                OTPTextField1.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextfield4{
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField5{
                OTPTextfield4.becomeFirstResponder()
            }
            if textField == OTPTextField6{
                OTPTextField5.becomeFirstResponder()
            }
            if textField == OTPTextField1{
                OTPTextField1.resignFirstResponder()
            }
            textField.text = "-"
            return false
        }else if textField.text!.count >= 1{
            if textField == OTPTextField1{
                OTPTextField2.text = ""
                OTPTextField2.becomeFirstResponder()
            }
            if textField == OTPTextField2{
                OTPTextField3.text = ""
                OTPTextField3.becomeFirstResponder()
            }
            if textField == OTPTextField3{
                OTPTextfield4.text = ""
                OTPTextfield4.becomeFirstResponder()
            }
            if textField == OTPTextfield4{
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
