//
//  ForgotPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submitButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToVerifyForgotPasswordVC", sender: nil)
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
