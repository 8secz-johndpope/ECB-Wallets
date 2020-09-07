//
//  FinishSupportViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class FinishSupportViewController: UIViewController {

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

    @IBAction func gotoDashboardButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoDashboardVC", sender: nil)
    }
    
}
