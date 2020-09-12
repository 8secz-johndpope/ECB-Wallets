//
//  SignUpViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import Validator
class SignUpViewController: UIViewController {
    //MARK: - Models
    var isAgreeTeams = false
    var currentLocation = location()
    var listFlag = [flag]()
    //
    var password = ""
    var repeatPassword = ""
    var email = ""
    var phonCode = ""
    var phoneNumber = ""
    var fullName = ""
    var errorCount = 0
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
    //
    var spinerView:UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spiner.style = .whiteLarge
        spiner.startAnimating()
        spiner.translatesAutoresizingMaskIntoConstraints = false
        return spiner
    }()
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        print(driveToken)
        //Custom phoneCodeButton
        phoneCodeButton.layer.cornerRadius = 5
        phoneCodeButton.clipsToBounds = true
        // set textField Delegate
        userNameTextField.delegate = self
        emailTextField.delegate = self
        phoneCodeTextField.delegate = self
        passwordTextfield.delegate = self
        repeatPasswordTextField.delegate = self
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.keyboardType = .numberPad
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.keyboardType = .numberPad
        phoneCodeTextField.keyboardType = .numberPad
        //Get CurrentLocation from API and Update UI
        FlatCountryService.instant.getAllFlatCountry { (success, location, flags) in
            if success{
                self.listFlag = flags
                self.currentLocation = location
                self.phoneCodeLabel.text = "+\(self.currentLocation.phoneCode!)"
                self.phonCode = self.currentLocation.phoneCode!
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        
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
        //
        self.view.endEditing(true)
        //Step1: Valadation user input
        if isValadateFullName(input: userNameTextField.text!){
            errorCount = 0
            self.fullName = userNameTextField.text!
            if isValidEmail(email: emailTextField.text!){
                errorCount = 0
                self.email = emailTextField.text!
                if isValadatePhoneNumber(input: phoneCodeTextField.text!){
                    errorCount = 0
                    self.phoneNumber = phoneCodeTextField.text!
                    if isValadatePasswprd(input: passwordTextfield.text!){
                        errorCount = 0
                        self.password = passwordTextfield.text!
                        if repeatPasswordTextField.text == passwordTextfield.text{
                            errorCount = 0
                            self.repeatPassword = repeatPasswordTextField.text!
                        }else{
                            errorCount += 1
                            self.showToast(message: "Repeat must be the same with password")
                        }
                    }else{
                        errorCount += 1
                        self.showToast(message: "Password is must containt only 6 number")
                    }
                }else{
                    errorCount += 1
                    self.showToast(message: "Phone number must be in range 6 to 20 numbers")
                }
            }else{
                errorCount += 1
                self.showToast(message: "Email is wrong format")
            }
        }else{
            errorCount += 1
            self.showToast(message: NSLocalizedString("validate_username_key",comment: "validate_username_key"))
        }
        if errorCount == 0 && isAgreeTeams == true {
            //show spiner
            self.showSpiner()
            //Send thong tin len API
            AuthService.instan.register(username: fullName, email: email, password: password, password_confirm: repeatPassword, firebase_token: driveToken, phoneCode: phonCode, phoneNumber: phoneNumber) { (success, errorCode) in
                if success{
                    if errorCode == 0 {
                        self.spinerView.stopAnimating()
                        self.performSegue(withIdentifier: "goToVerifyAccountView", sender: nil)
                    }else{
                        self.spinerView.stopAnimating()
                        self.showAlert(errorCode: errorCode!)
                    }
                }else{
                    print("Fail to register")
                }
            }
        }else{
            print("Teams and conditions are not check")
        }
        
    }
    @IBAction func signInbuttonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoSignInVC", sender: nil)
    }
    //MARK: - Helper methods
    //Validate FullName
    func isValadateFullName(input:String) -> Bool{
        let range = NSRange(location: 0, length: input.utf16.count)
        let regex = try! NSRegularExpression(pattern:"[@$%^&*!?:<>/()+=-]", options: [.allowCommentsAndWhitespace])
        let character = regex.matches(in: input, options: [], range: range)
        
        if character.isEmpty && input.count >= 6 && input.count <= 50{
            return true
        }else{
            return false
        }
    }
    func isValadatePasswprd(input:String) -> Bool {
        return input.range(of: "^[0-9]{6,6}$", options: .regularExpression) != nil
    }
    func isValadatePhoneNumber(input:String) -> Bool {
        return input.range(of: "^[0-9]{6,20}$", options: .regularExpression) != nil
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    //Show spiner
    func showSpiner(){
        self.view.addSubview(spinerView)
        spinerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    //MARK: UI NavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToVerifyAccountView"{
            let dest = segue.destination as! VerifyAccountViewController
            dest.password = password
            dest.repeatPassword = repeatPassword
            dest.email = email
            dest.phoneNumber = phoneNumber
            dest.phonCode = phonCode
            dest.fullName = fullName
        }
    }
    
}
//MARK: UITextFieldDelegate
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == passwordTextfield{
            passwordTextfield.text?.isValidatePassword(completionHandler: { (error) in
                if error == nil{
                    print("True")
                }else{
                    self.showToast(message: error!)
                }
            })
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
extension SignUpViewController:listFlatDelegate{
    func getFlagCountryAndUpdate(_ flafCountry: flag) {
        self.phoneCodeLabel.text = "+\(flafCountry.phoneCode!)"
        self.phonCode = flafCountry.phoneCode!
        let url = URL(string: flafCountry.imageUrl!)
        do{
            let dataImage = try Data(contentsOf: url!)
            self.phoneCodeButton.setImage(UIImage(data: dataImage), for: UIControl.State.normal)
        }catch{
            print("Can't dowload image from \(url)")
        }
    }
}
