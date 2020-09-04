//
//  BuyCoinViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/4/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class BuyCoinViewController: UIViewController {
    let listCurrency = ["USD", "VND"]
    //MARK: UI Elements
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heightPurpleView: NSLayoutConstraint!
    @IBOutlet weak var whiteView: BoundTopLeftAndTopRightCornerView!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    
    @IBOutlet weak var currenyAmountLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var BTCAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //
    let pickerViewCurrency:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        scrollView.bindToKeyboard()
        //Register cell for tableView
        let nibName = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for purpleView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightPurpleView.constant = tableViewHeight + 80
    }
    
    //MARK: UI events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseWalletWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoListWalletVC", sender: nil)
    }
    @IBAction func choosePaymentMethodButton(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSelectPaymentVC", sender: nil)
    }
    
    @IBAction func chooseKindOfCurrencyButtonWasPressed(_ sender: Any) {
        pickerViewCurrency.delegate = self
        pickerViewCurrency.dataSource = self
        pickerViewCurrency.frame = CGRect(x: self.view.frame.width - 15 - 80, y: 270, width: 80, height: 100)
        pickerViewCurrency.isHidden = false
        self.whiteView.addSubview(pickerViewCurrency)
    }
    @IBAction func buyButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoFinishBuyVC", sender: nil)
    }
    @IBAction func allTransactionWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoWalletTransactionVC", sender: nil)
    }
    //MARK: UINavigation Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoListWalletVC"{
            let dest = segue.destination as! ListWalletViewController
            dest.delegate = self
        }
        if segue.identifier == "gotoSelectPaymentVC"{
            let dest = segue.destination as! SelectPaymentViewController
            dest.delegate = self
        }
    }
}
//MARK: UITableViewDelegate and UITableViewDataSource
extension BuyCoinViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Jump to transactionDetailVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionDetailVC = storyboard.instantiateViewController(identifier: "transactionDetailVC") as! TransactionDetailViewController
        self.present(transactionDetailVC, animated: true, completion: nil)
    }
}
//MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension BuyCoinViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)
        -> Int {
        return listCurrency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listCurrency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currenyAmountLabel.text = listCurrency[row]
        pickerView.isHidden = true
        
    }
}
//MARK: listWalletDelegate
extension BuyCoinViewController:listWalletDelegate{
    func getWalletAndUpdate(_ wallet: Wallet) {
        self.currencyImage.image = UIImage(named: wallet.image)
        self.currencyNameLabel.text = wallet.name
    }
}
extension BuyCoinViewController:selectPaymentDelegate{
    func getPaymentMethodAndUpdate(_ paymentMethod: PaymentMethod) {
        self.paymentMethodLabel.text = paymentMethod.nameMethod
    }
}
