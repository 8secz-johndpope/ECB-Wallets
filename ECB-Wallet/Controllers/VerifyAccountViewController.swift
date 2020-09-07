//
//  VerifyAccountViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class VerifyAccountViewController: UIViewController {

    @IBOutlet weak var OTPTextField1: UITextField!
    @IBOutlet weak var OTPTextField2: UITextField!
    @IBOutlet weak var OTPTextField3: UITextField!
    @IBOutlet weak var OTPTextfield4: UITextField!
    @IBOutlet weak var OTPTextField5: UITextField!
    @IBOutlet weak var OTPTextField6: UITextField!
    @IBOutlet weak var expriedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set textField Delegate
        OTPTextField1.becomeFirstResponder()
        
        OTPTextField1.delegate = self
        OTPTextField2.delegate = self
        OTPTextField3.delegate = self
        OTPTextfield4.delegate = self
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
    //MARK: - UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
        let OTP = "\(OTPTextField1.text!)\(OTPTextField2.text!)\(OTPTextField3.text!)\(OTPTextfield4.text!)\(OTPTextField5.text!)\(OTPTextField6.text!)"
        if OTP == "123456"{
            self.performSegue(withIdentifier: "goToFinishSignUpVC", sender: nil)
        }
    }
    @IBAction func resendOPTButtonWasPressed(_ sender: Any) {
        print("Resend OTP")
    }
    
}
//
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
