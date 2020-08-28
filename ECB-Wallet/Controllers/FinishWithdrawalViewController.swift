//
//  FinishWithdrawalViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class FinishWithdrawalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func gotoDashboardButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToDashboardVC", sender: nil)
    }
    

    

}
