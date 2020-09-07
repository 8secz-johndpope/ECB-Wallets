//
//  DetailNotificationViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/28/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DetailNotificationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageNotification: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tittleNotificationLabel: UILabel!
    @IBOutlet weak var contentNotificationLabel: UILabel!
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
    
    @IBAction func downButtonWasPressed(_ sender: Any) {
        let bottomOfSet = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOfSet, animated: true)
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
