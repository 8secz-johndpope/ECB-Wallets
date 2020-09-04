//
//  FinishBuyViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/4/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class FinishBuyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoDashboardButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoDashboardVC", sender: nil)
    }
    
}
