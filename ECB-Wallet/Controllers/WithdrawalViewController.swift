//
//  WithdrawalViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class WithdrawalViewController: UIViewController {
    let listCurrency = ["USD", "VND"]
    var yPickerView:CGFloat = 0.0
    //MARK: - UI elements
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var walletAddressTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightPurpleView: NSLayoutConstraint!
    @IBOutlet weak var valueAmountTextField: UITextField!
    @IBOutlet weak var unitAmountLabel: UILabel!
    
    //
    let pickerViewCurrency:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
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
    //get height of safeView and set yPickerView for pickerViewCurrency
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        //Check internet are available
        if CheckInternet.Connection(){
            print("Internet is available")
        }else{
            //Show dialogVC
            let diglogVC = DialogViewController()
            diglogVC.modalPresentationStyle = .custom
            present(diglogVC, animated: true, completion: nil)
        }
        
        if view.safeAreaInsets.top == 44 {
            yPickerView = 380
        }else{
            yPickerView = 380 - view.safeAreaInsets.top
           }
        print(yPickerView)
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
    @IBAction func chooseUnitAmountButtonWasPressed(_ sender: Any) {
        pickerViewCurrency.delegate = self
        pickerViewCurrency.dataSource = self
        pickerViewCurrency.frame = CGRect(x: self.view.frame.width - 15 - 80, y: yPickerView, width: 80, height: 100)
        pickerViewCurrency.isHidden = false
        self.view.addSubview(pickerViewCurrency)
    }
    
    @IBAction func withdrawalButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoFinishWithdrawalVC", sender: nil)
    }
    @IBAction func allTransactionButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoWalletTransaction", sender: nil)
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
extension WithdrawalViewController:UIPickerViewDelegate, UIPickerViewDataSource{
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
        self.unitAmountLabel.text = listCurrency[row]
        pickerView.isHidden = true
        
    }
}
