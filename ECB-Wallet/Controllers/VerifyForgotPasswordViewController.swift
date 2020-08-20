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
    }
    

    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonwasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCreateNewPasswordVC", sender: nil)
    }
    @IBAction func resendOTPButtonWasPressed(_ sender: Any) {
    }
    
}
