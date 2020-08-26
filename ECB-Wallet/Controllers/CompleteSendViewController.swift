//
//  CompleteSendViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/26/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CompleteSendViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveWalletAdressWasPressed(_ sender: Any) {
    }
    
    @IBAction func gotoDashboardWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToDashboardVC", sender: nil)
    }
    
    
}
