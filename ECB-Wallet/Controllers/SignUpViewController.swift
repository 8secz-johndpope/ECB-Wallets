//
//  SignUpViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: - Models
    var isAgreeTeams = false
    var currentLocation = location()
    var listFlag = [flag]()
    //MARK: - UI elements
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneCodeButton: UIButton!
    @IBOutlet weak var phoneCodeLabel: UILabel!
    @IBOutlet weak var phoneCodeTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var checkButton: setBorderAndRoundCornerButton!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //Custom phoneCodeButton
        phoneCodeButton.layer.cornerRadius = 5
        phoneCodeButton.clipsToBounds = true
        // setup keyboard events
        scrollView.bindToKeyboard()
        // set textField Delegate
        userNameTextField.delegate = self
        emailTextField.delegate = self
        phoneCodeTextField.delegate = self
        passwordTextfield.delegate = self
        repeatPasswordTextField.delegate = self
        passwordTextfield.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Get CurrentLocation from API and Update UI
        FlatCountryService.instant.getAllFlatCountry { (success, location, flags) in
            if success{
                self.listFlag = flags
                self.currentLocation = location
                self.phoneCodeLabel.text = "+\(self.currentLocation.phoneCode!)"
                let queue = DispatchQueue(label: "handleDowload")
                queue.async {
                    guard let urlImage = self.currentLocation.imageUrl else {return}
                    let url = URL(string: urlImage)
                    do{
                        let imageData = try Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            self.phoneCodeButton.setBackgroundImage(UIImage(data: imageData), for: UIControl.State.normal)
                        }
                    }catch{
                        print("Can't not dowload image from \(url)")
                    }
                }
            }else{
                print("Can not get all Flags and location")
            }
        }
        
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
    //MARK: - UI events
    @IBAction func phoneCodeButtonWasPressed(_ sender: Any) {
        let listFlatVC = ListFlatViewController()
        listFlatVC.listFlats = listFlag
        listFlatVC.delegate = self
        listFlatVC.modalPresentationStyle = .custom
        self.present(listFlatVC, animated: true, completion: nil)
    }
    @IBAction func hidePasswordButtonWasPressed(_ sender: Any) {
        if passwordTextfield.isSecureTextEntry{
            passwordTextfield.isSecureTextEntry = false
        }else{
            passwordTextfield.isSecureTextEntry = true
        }
    }
    @IBAction func hideRepeatPasswordButtonWasPressed(_ sender: Any) {
        if repeatPasswordTextField.isSecureTextEntry{
            repeatPasswordTextField.isSecureTextEntry = false
        }else{
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func checkButtonWasPressed(_ sender: Any) {
        if isAgreeTeams == false{
            checkButton.setBackgroundImage(UIImage(named: "checkButton"), for: UIControl.State.normal)
            isAgreeTeams = true
        }else{
            isAgreeTeams = false
            checkButton.setBackgroundImage(UIImage(named: ""), for: UIControl.State.normal)
            return
        }
    }
    @IBAction func termAndConditionButtonWasPressed(_ sender: Any) {
    }
    @IBAction func signUpButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToVerifyAccountView", sender: nil)
    }
    @IBAction func signInbuttonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoSignInVC", sender: nil)
    }
    //MARK: - Helper methods
    @objc func handleTapToHideKeyboard(){
        self.view.endEditing(true)
    }
}
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField{
            emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            phoneCodeTextField.becomeFirstResponder()
        }else if textField == phoneCodeTextField{
            passwordTextfield.becomeFirstResponder()
        }else if textField == passwordTextfield{
            repeatPasswordTextField.becomeFirstResponder()
        }else{
            repeatPasswordTextField.resignFirstResponder()
        }
        return true
    }
}
extension SignUpViewController:listFlatDelegate{
    func getFlagCountryAndUpdate(_ flafCountry: flag) {
        self.phoneCodeLabel.text = "+\(flafCountry.phoneCode!)"
        let url = URL(string: flafCountry.imageUrl!)
        do{
            let dataImage = try Data(contentsOf: url!)
            self.phoneCodeButton.setImage(UIImage(data: dataImage), for: UIControl.State.normal)
        }catch{
            print("Can't dowload image from \(url)")
        }
    }
}
