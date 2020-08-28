//
//  WithdrawalViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class WithdrawalViewController: UIViewController {
    //MARK: - UI elements
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var walletAddressTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightPurpleView: NSLayoutConstraint!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "WithdrawalTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WithdrawalTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for purpleView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightPurpleView.constant = tableViewHeight + 100
    }
    
    //MARK: - UI Events
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseWalletWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoListWalletVC", sender: nil)
        
    }
    @IBAction func chooseWalletAddressButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoAdressWalletVC", sender: nil)
    }
    @IBAction func scanQRCodeButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoScanQRVC", sender: nil)
    }
    
    @IBAction func withdrawalButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoFinishWithdrawalVC", sender: nil)
    }
    @IBAction func allTransactionButtonWasPressed(_ sender: Any) {
    }
}
extension WithdrawalViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WithdrawalTableViewCell", for: indexPath) as! WithdrawalTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
