//
//  ConfirmSendViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/25/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ConfirmSendViewController: UIViewController {
    //MARK: - UI Elements
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var currencyUnitLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sendToLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    //MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
    }
    //MARK: - Helper Methods
    func customContainerView(){
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
    }
    
}
