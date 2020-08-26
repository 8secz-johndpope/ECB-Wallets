//
//  SaveWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/26/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SaveWalletViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var nameRememberTextField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var addressWalletLabel: UILabel!
    
    var stringCounter:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set delegate for TextField
        nameRememberTextField.delegate = self
        //
        scrollView.bindToKeyboard()
        
    }
    
    @IBAction func saveButtonWasPressed(_ sender: Any) {
        
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - UITextFieldDelegate
extension SaveWalletViewController:UITextFieldDelegate{
    //Update counterLabel when user typing
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let stringInput = textField.text
        guard let counter = stringInput?.count else {return}
        if counter > 50 {
            print("Over 50 character")
        }else{
            counterLabel.text = "\(counter)/50"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 50
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameRememberTextField{
            nameRememberTextField.resignFirstResponder()
        }
        return true
    }
}
