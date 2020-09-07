//
//  ContactVCViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ContactVCViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // set delegate for textFields
        userNameTextField.delegate = self
        emailTextField.delegate = self
        contentTextField.delegate = self
        //
        scrollView.bindToKeyboard()
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
    
    @IBAction func submitButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoFinishSuppotVC", sender: nil)
    }
    
}
extension ContactVCViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField{
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            contentTextField.becomeFirstResponder()
        }else{
            contentTextField.resignFirstResponder()
        }
        return true
    }
}
