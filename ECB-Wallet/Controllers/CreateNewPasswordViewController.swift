//
//  CreateNewPasswordViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswodTextField: UITextField!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func createButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFinishSignUpVC", sender: nil)
    }
    //MARK: - UI NavigationCotroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFinishSignUpVC"{
            let destVC = segue.destination as! FinishSignUpViewController
            destVC.content = "You have successfully changed your password"
        }
    }
}
