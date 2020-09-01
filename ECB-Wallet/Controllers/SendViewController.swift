//
//  SendViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SendViewController: UIViewController,listWalletDelegate, addressWalletDelegate {
    let listCurrency = ["USD", "VND"]
    var yPickerView:CGFloat = 0.0
    //MARK: - UI Elements
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyTitleLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var unitCurrencyLabel: UILabel!
    @IBOutlet weak var valueUSDLabel: UILabel!
    @IBOutlet weak var addressWalletTextField: UITextField!
    @IBOutlet weak var valueCurencyBTC: UILabel!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var unitAmountLabel: UILabel!
    @IBOutlet weak var valueAmountTextField: UITextField!
    
    //
    let pickerViewCurrency:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        //
        
    }
    //get height of safeView and set yPickerView for pickerViewCurrency
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.safeAreaInsets.top == 44 {
            yPickerView = 530
        }else{
            yPickerView = 530 - view.safeAreaInsets.top
        }
        print(yPickerView)
    }
    //MARK: - ListWalletDelegate
    //get wallet, which selected at ListWalletVC and than update UI
    func getWalletAndUpdate(_ wallet: Wallet) {
        currencyImage.image = UIImage(named: wallet.image)
        currencyTitleLabel.text = wallet.name
    }
    //get address wallet, which selected at AddressWalletVC and than update UI
    func getAddressWalletAndUpdate(_ addressWallet: AddressWallet) {
        addressWalletTextField.text = addressWallet.addressWallet
    }
    //MARK: - UI Event
    
    @IBAction func listWalletButtonWasPressed(_ sender: Any) {
        //Jump to ListWalletVC
        self.performSegue(withIdentifier: "goToListWalletVC", sender: nil)
    }
    @IBAction func addressListWalletWasPressed(_ sender: Any) {
        //Jump to AddressWalletVC
        self.performSegue(withIdentifier: "goToAddressWalletVC", sender: nil)
    }
    @IBAction func QRScanButtonWasPressed(_ sender: Any) {
        //Jump to ScanQRVC
        self.performSegue(withIdentifier: "goToScanQRVC", sender: nil)
    }
    @IBAction func listUnitAmountButtonWasPressed(_ sender: Any) {
        pickerViewCurrency.delegate = self
        pickerViewCurrency.dataSource = self
        pickerViewCurrency.frame = CGRect(x: self.view.frame.width - 15 - 80, y: yPickerView, width: 80, height: 100)
        pickerViewCurrency.isHidden = false
        self.view.addSubview(pickerViewCurrency)
    }
    @IBAction func resetButtonWasPressed(_ sender: Any) {
        addressWalletTextField.text = ""
        valueCurencyBTC.text = ""
        contentTextField.text = ""
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
        //Jump to ConfirmSendVC
        self.performSegue(withIdentifier: "goToConfrmSendVC", sender: nil)
    }
    //MARK: UI NavigationController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToListWalletVC"{
            let dest = segue.destination as! ListWalletViewController
            dest.delegate = self
        }
        if segue.identifier == "goToAddressWalletVC"{
            let dest = segue.destination as! AddressWalletViewController
            dest.delegate = self
        }
        if segue.identifier == "goToScanQRVC"{
            let dest = segue.destination as! ScanQRViewController
            dest.delegate = self
        }
    }
    //MARK: Helper method
    @objc func keyboardWillShow(notification:NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.size.height)
    }
    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentOffset = .zero
    }
    @objc func handleTapToHideKeyboard() {
        self.view.endEditing(true)
    }
    
}
//MARK: scanQRDelegate
extension SendViewController:scanQRDelegate{
    func getInfoQRCode(_ infoQR: String) {
        self.addressWalletTextField.text = infoQR
    }
    
}
extension SendViewController:UIPickerViewDelegate, UIPickerViewDataSource{
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
