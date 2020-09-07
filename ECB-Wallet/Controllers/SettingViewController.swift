//
//  SettingViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var switchControll: UISwitch!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var termAndConditionView: UIView!
    
    
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
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchNotificationButtonWasPressed(_ sender: Any) {
    }
    @IBAction func listCurrencyButtonWasPressed(_ sender: Any) {
        
    }
    @IBAction func listLanguageButtonWasPressed(_ sender: Any) {
    }
    
}

    
    
    

