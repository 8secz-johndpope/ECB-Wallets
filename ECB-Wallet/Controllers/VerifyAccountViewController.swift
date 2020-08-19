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
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFinishSignUpVC", sender: nil)
    }
    @IBAction func resendOPTButtonWasPressed(_ sender: Any) {
        print("Resend OTP")
    }
    
}
//
extension VerifyAccountViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == OTPTextField1{
            OTPTextField2.becomeFirstResponder()
        }else if textField == OTPTextField2{
            OTPTextField3.becomeFirstResponder()
        }else if textField == OTPTextField3{
            OTPTextfield4.becomeFirstResponder()
        }else if textField == OTPTextfield4{
            OTPTextField5.becomeFirstResponder()
        }else if textField == OTPTextField5{
            OTPTextField6.becomeFirstResponder()
        }else{
            OTPTextField6.resignFirstResponder()
        }
        return true
    }
}
