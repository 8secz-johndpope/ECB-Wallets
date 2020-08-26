//
//  PassSendConfirmViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/26/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class PassSendConfirmViewController: UIViewController {
    //MARK: - UI Elements
    
    @IBOutlet weak var passcodeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        setupPasscode()
    }
    //MARK: - UI Events
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Helper Method
    func setupPasscode(){
        let passcode = Passcode()
        passcode.frame = self.passcodeView.bounds
        passcode.becomeFirstResponder()
        self.passcodeView.addSubview(passcode)
        passcode.didFinishedEnterCode = { code in
            //Check the user password and than do something
            if code == "123456"{
                self.performSegue(withIdentifier: "goToCompleteSendVC", sender: nil)
            }
            print(code)
        }
    }
    

}
