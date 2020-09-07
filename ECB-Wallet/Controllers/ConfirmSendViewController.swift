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
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
        //Jump to SendPassVC
        self.performSegue(withIdentifier: "goToSendPassVC", sender: nil)
        
    }
    //MARK: - Helper Methods
    func customContainerView(){
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
    }
    
}
