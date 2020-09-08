//
//  DialogViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/7/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DialogViewController: UIViewController {
    var counter = 0
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func tryAgainButtonWasPressed(_ sender: Any) {
        counter += 1
        if counter == 3{
            button.setTitle("Go To Setting", for: UIControl.State.normal)
        }else if counter == 4 {
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else {return}
            if UIApplication.shared.canOpenURL(settingUrl){
                UIApplication.shared.open(settingUrl) { (success) in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
