//
//  FinishSignUpViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/19/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class FinishSignUpViewController: UIViewController {
    //MARK: Models
    var content:String?
    //MARK: - UI Element
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - UI VIewController
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let labelContent = content else {return}
        titleLabel.text = labelContent
    }
    //MARK: - UI Events
    @IBAction func signInButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToSignInVC", sender: nil)
    }
    
}
