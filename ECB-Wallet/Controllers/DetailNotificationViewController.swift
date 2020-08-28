//
//  DetailNotificationViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/28/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DetailNotificationViewController: UIViewController {

    @IBOutlet weak var imageNotification: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tittleNotificationLabel: UILabel!
    @IBOutlet weak var contentNotificationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func downButtonWasPressed(_ sender: Any) {
    }
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
