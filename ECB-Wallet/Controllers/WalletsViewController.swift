//
//  WalletsViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/21/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class WalletsViewController: UIViewController {
    //MARK: - UI elements
    @IBOutlet weak var valueCurrencyLabel: UILabel!
    @IBOutlet weak var unitCurrencyLabel: UILabel!
    @IBOutlet weak var valueUSDLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hieghtLightBlueView: NSLayoutConstraint!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register tableView Cell
        let nibName = UINib(nibName: "WalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WalletTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for lightBlueView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()

            return tableView.contentSize.height
        }
        hieghtLightBlueView.constant = tableViewHeight
    }
    //MARK: - UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func refreshButtonWasPressed(_ sender: Any) {
    }
    

}
//MARK: - UI tableView delegate&DataSource
extension WalletsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTableViewCell", for: indexPath) as! WalletTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "gotoDetailWalletVC", sender: nil)
    }
}
