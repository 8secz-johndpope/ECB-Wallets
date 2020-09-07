//
//  AccountViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/28/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    //MARK: UI element
    @IBOutlet weak var profileImage: BoundCornerImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    //MARK: UI ViewController
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
    //MARK: - UI Event

    @IBAction func settingButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSettingVC", sender: nil)
    }
    @IBAction func signOutButtonwasPressed(_ sender: Any) {
        
    }
    
    @IBAction func editProfileButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoEditProfileVC", sender: nil)
    }
    @IBAction func changePasswordWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "changePasswordVC", sender: nil)
    }
    @IBAction func manageWalletButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoManageWalletVC", sender: nil)
    }
    @IBAction func transactionButtonWasPressed(_ sender: Any) {
    }
    @IBAction func supportButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSupportCenter", sender: nil)
    }
}
