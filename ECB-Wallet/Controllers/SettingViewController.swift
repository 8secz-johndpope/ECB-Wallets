//
//  SettingViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    let listCurrency = ["USD", "VND"]
    
    @IBOutlet weak var switchControll: UISwitch!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var privacyPolicyView: UIView!
    @IBOutlet weak var termAndConditionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func switchNotificationButtonWasPressed(_ sender: Any) {
    }
    @IBAction func listCurrencyButtonWasPressed(_ sender: Any) {
        let pickerViewCurrency = UIPickerView()
        pickerViewCurrency.delegate = self
        pickerViewCurrency.dataSource = self
        pickerViewCurrency.frame = CGRect(x: self.view.frame.width - 15 - 80, y: 240, width: 80, height: 100)
        pickerViewCurrency.backgroundColor = UIColor.white
        self.view.addSubview(pickerViewCurrency)
    }
    @IBAction func listLanguageButtonWasPressed(_ sender: Any) {
    }
    
}
extension SettingViewController:UIPickerViewDelegate, UIPickerViewDataSource{
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
        self.currencyLabel.text = listCurrency[row]
        pickerView.isHidden = true
        
    }
    
    
    
}
