//
//  DashboardViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/21/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    //MARK: - UI Elements
    @IBOutlet weak var valueCurrencyLable: UILabel!
    @IBOutlet weak var unitCurrencyLabel: UILabel!
    @IBOutlet weak var valueUSDLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightPurpleView: NSLayoutConstraint!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        //Resister Cell for collectionView
        let nibCollectionCell = UINib(nibName: "DashboardCollectionViewCell", bundle: nil)
        collectionView.register(nibCollectionCell, forCellWithReuseIdentifier: "DashboardCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        //Register Cell for tableView
        let nibTableCell = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(nibTableCell, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for purpleView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()

            return tableView.contentSize.height
        }
        heightPurpleView.constant = tableViewHeight
    }
    //MARK: - UI Event
    @IBAction func notificationButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoNotificationVC", sender: nil)
    }
    @IBAction func refreshButtonWasPressed(_ sender: Any) {
    }
    @IBAction func sendButtonWasPressed(_ sender: Any) {
    }
    @IBAction func recieveButtonWasPressed(_ sender: Any) {
    }
    @IBAction func buyButtonWasPressed(_ sender: Any) {
    }
    @IBAction func withdrawButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoWithdrawalVC", sender: nil)
    }
    @IBAction func allWalletsButtonWasPressed(_ sender: Any) {
    }
    @IBAction func allTransactionButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoWalletTransactionVC", sender: nil)
    }
    
    

}
//MARK: - UICollectionView delegate&Datasource
extension DashboardViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 145)
    }
}
//MARK: - UITableView delegate &Datasource
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
