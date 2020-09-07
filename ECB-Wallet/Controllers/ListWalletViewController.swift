//
//  ListWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/24/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
protocol listWalletDelegate:class {
    func getWalletAndUpdate(_ wallet:Wallet)
}
class ListWalletViewController: UIViewController,UITextFieldDelegate {
    //MARK: Model
    let listWallet:[Wallet] = {
        let wallet1 = Wallet(name: "Bitcoin (BTC)", image: "biconImage")
        let wallet2 = Wallet(name: "Bitcoin Cash (BCH)", image: "biconImage")
        let wallet3 = Wallet(name: "Bitcoin Goal (BTG)", image: "biconImage")
        let wallet4 = Wallet(name: "Tether (USDT)", image: "biconImage")
        let wallet5 = Wallet(name: "Ethreum (ETH)", image: "biconImage")
        let wallet6 = Wallet(name: "Ethereum Classic (ETC)", image: "biconImage")
        let wallet7 = Wallet(name: "USD Coin (USDC)", image: "biconImage")
        return [wallet1,wallet2,wallet3,wallet4,wallet5,wallet6,wallet7]
    }()
    weak var delegate:listWalletDelegate?
    //MARK: - UI element
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register cell for tableView
        let nibName = UINib(nibName: "ListWalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ListWalletTableViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        //
        searchTextField.delegate = self
        //
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
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField{
            searchTextField.resignFirstResponder()
        }
        return true
    }
    //MARK: - UI Event
    
    @IBAction func searchButtonWasPressed(_ sender: Any) {
        print("Search")
    }
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
}
//MARK: - UITableview Delegate and Datasource
extension ListWalletViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWallet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListWalletTableViewCell") as! ListWalletTableViewCell
        cell.imageView?.image = UIImage(named: listWallet[indexPath.row].image)
        cell.nameWallet.text = listWallet[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Select Wallet and than dismiss ListWalletVC
        delegate?.getWalletAndUpdate(listWallet[indexPath.row])
        self.dismiss(animated: true, completion: nil)
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
