//
//  RecieveViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class RecieveViewController: UIViewController {
    //MARK: - UI Elements
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var QRCodeImage: UIImageView!
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstantPurpleView: NSLayoutConstraint!
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

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
        heightConstantPurpleView.constant = tableViewHeight + 80
    }
    override func viewDidAppear(_ animated: Bool) {
        //Call generateQRCode to make qrcode image and update for QRCodeImage
        let qrImage = generateQRCode(from: "test generate QR code")
        QRCodeImage.image = qrImage
    }
    //MARK: - UI Events

    @IBAction func chooseWalletWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToListWallet", sender: nil)
        
    }
    @IBAction func copyWalletAddressButtonWasPressed(_ sender: Any) {
    }
    @IBAction func shareButtonWasPressed(_ sender: Any) {
        //Share WalletAddress
        let shareItem = ["Test to share your wallet address"]
        let ac = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
        self.present(ac, animated: true, completion: nil)
    }
    @IBAction func allTransactionsWasPressed(_ sender: Any) {
    }
    //MARK: - Helper Method
    //This is aa function to make a QRCode Image
    func generateQRCode(from string:String) -> UIImage?{
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
//MARK: - UITableViewDelegate and UITableViewDataSource
extension RecieveViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        return cell
    }
}
