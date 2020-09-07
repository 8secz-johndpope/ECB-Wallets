//
//  VerifyForgotPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class VerifyForgotPasswordViewController: UIViewController {

    @IBOutlet weak var expriedLabel: UILabel!
    @IBOutlet weak var OTPTextfield1: UITextField!
    @IBOutlet weak var OTPTextField2: UITextField!
    @IBOutlet weak var OTPTextField3: UITextField!
    @IBOutlet weak var OTPTextField4: UITextField!
    @IBOutlet weak var OTPTextField5: UITextField!
    @IBOutlet weak var OTPTextField6: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set textField Delegate
        OTPTextfield1.becomeFirstResponder()
               
        OTPTextfield1.delegate = self
        OTPTextField2.delegate = self
        OTPTextField3.delegate = self
        OTPTextField4.delegate = self
        OTPTextField5.delegate = self
        OTPTextField6.delegate = self
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
    

    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonwasPressed(_ sender: Any) {
        let OTP = "\(OTPTextfield1.text!)\(OTPTextField2.text!)\(OTPTextField3.text!)\(OTPTextField4.text!)\(OTPTextField5.text!)\(OTPTextField6.text!)"
        if OTP == "123456"{
            self.performSegue(withIdentifier: "goToCreateNewPasswordVC", sender: nil)
        }
    }
    @IBAction func resendOTPButtonWasPressed(_ sender: Any) {
    }
    
}
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

