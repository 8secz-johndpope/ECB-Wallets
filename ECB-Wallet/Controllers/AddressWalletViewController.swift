//
//  AddressWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
protocol addressWalletDelegate:class {
    func getAddressWalletAndUpdate(_ addressWallet: AddressWallet)
}
class AddressWalletViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Models
    let addressWallet:[AddressWallet] = {
        let addressWallet1 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet2 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet3 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet4 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet5 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet6 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet7 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet8 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        let addressWallet9 = AddressWallet(ownerName: "Mr. John", addressWallet: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh")
        return [addressWallet1, addressWallet2, addressWallet3, addressWallet4, addressWallet5, addressWallet6, addressWallet7, addressWallet8, addressWallet9]
    }()
    weak var delegate:addressWalletDelegate?
    //MARK: - UI Element
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "AddressWalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AddressWalletTableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        //
        searchTextField.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        //Check internet are available
        if CheckInternet.Connection(){
            print("Internet is available")
        }else{
            //Show dialogVC
            let diglogVC = DialogViewController()
            diglogVC.modalPresentationStyle = .custom
            present(diglogVC, animated: true, completion: nil)
        }
    }
    //MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField{
            searchTextField.resignFirstResponder()
        }
        return true
    }
    //MARK: - UI Events
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchButtonWasPressed(_ sender: Any) {
        print("Search")
    }
    
}
//MARK: - UITableViewDelegate and DataSource
extension AddressWalletViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressWallet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressWalletTableViewCell") as! AddressWalletTableViewCell
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.ownerWalletLabel.text = addressWallet[indexPath.row].ownerName
        cell.addressWalletLabel.text = addressWallet[indexPath.row].addressWallet
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //send wallet address to sendVC and than dismiss AddressWalletVC
        self.delegate?.getAddressWalletAndUpdate(addressWallet[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
