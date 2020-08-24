//
//  SendViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {
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
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    //MARK: - UI Event
    
    @IBAction func listWalletButtonWasPressed(_ sender: Any) {
    }
    @IBAction func addressListWalletWasPressed(_ sender: Any) {
    }
    @IBAction func QRScanButtonWasPressed(_ sender: Any) {
    }
    @IBAction func resetButtonWasPressed(_ sender: Any) {
        addressWalletTextField.text = ""
        valueCurencyBTC.text = ""
        contentTextField.text = ""
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
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
