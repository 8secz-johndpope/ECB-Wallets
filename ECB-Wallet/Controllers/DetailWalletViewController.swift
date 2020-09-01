//
//  DetailWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/1/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DetailWalletViewController: UIViewController {

    @IBOutlet weak var heightLightBlueView: NSLayoutConstraint!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var currencyUnitLabel: UILabel!
    @IBOutlet weak var valueUSDCurrencyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "DetailWalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "DetailWalletTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for lightBlueView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightLightBlueView.constant = tableViewHeight
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func buyButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func withdrawalButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
    }
    @IBAction func receiveButtonWasPressed(_ sender: Any) {
    }
    @IBAction func chooseDurationTimeButtonWasPressed(_ sender: Any) {
    }
    @IBAction func segmentControllTransactionWasPressed(_ sender: Any) {
    }
}
extension DetailWalletViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWalletTableViewCell", for: indexPath) as! DetailWalletTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
