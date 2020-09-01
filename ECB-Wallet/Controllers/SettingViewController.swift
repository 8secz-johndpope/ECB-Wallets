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

    
    
    

