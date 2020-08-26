//
//  CompleteSendViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/26/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class CompleteSendViewController: UIViewController {
    //MARK: - Models
    var valueSendCurrency = "0.00001234"
    var unitSendCurreny = "BTC"
    var addressWallet = "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh"
    //MARK: - UI Elements
    @IBOutlet weak var contentLabel: UILabel!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //Custom text for contentLabel
        let paragrapStyle = NSMutableParagraphStyle()
        paragrapStyle.alignment = .center
        paragrapStyle.lineSpacing = 6.0
        
        let attributedText = NSMutableAttributedString(string: "You've just made a successful transfer of", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular),.foregroundColor:UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1), .paragraphStyle:paragrapStyle])
        attributedText.append(NSAttributedString(string: " \(self.valueSendCurrency) \(self.unitSendCurreny) ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), .foregroundColor:UIColor(red: 243/255, green: 71/255, blue: 100/255, alpha: 1), .paragraphStyle:paragrapStyle]))
        attributedText.append(NSAttributedString(string: "to the wallet address ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular),.foregroundColor:UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1), .paragraphStyle:paragrapStyle]))
        attributedText.append(NSAttributedString(string: self.addressWallet, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), .foregroundColor:UIColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1), .paragraphStyle:paragrapStyle]))
        contentLabel.attributedText = attributedText
    }
    //MARK: - UI Events
    @IBAction func saveWalletAdressWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSaveWalletVC", sender: nil)
    }
    
    @IBAction func gotoDashboardWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backToDashboardVC", sender: nil)
    }
    
    
}
