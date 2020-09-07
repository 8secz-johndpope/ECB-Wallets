//
//  SelectPaymentViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/4/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
protocol selectPaymentDelegate:class{
    func getPaymentMethodAndUpdate(_ paymentMethod:PaymentMethod)
}
class SelectPaymentViewController: UIViewController {
    //MARK: Models
    var paymentMethods:[PaymentMethod] = [
        PaymentMethod(imageMethod: "visaIcon", nameMethod: "Visa Card", isSelected: true),
        PaymentMethod(imageMethod: "masterCardIcon", nameMethod: "Master Card", isSelected: false)
    ]
    weak var delegate:selectPaymentDelegate?
    //MARK: UI Elements
    @IBOutlet weak var heightTableViewAnchor: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableView.isScrollEnabled = false
        
        //register cell for tableView
        let nibName = UINib(nibName: "SelectPaymentTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SelectPaymentTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for tableview
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightTableViewAnchor.constant = tableViewHeight
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
    //MARK: - UI Events
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension SelectPaymentViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPaymentTableViewCell", for: indexPath) as! SelectPaymentTableViewCell
        if paymentMethods[indexPath.row].isSelected{
            cell.methodImage.image = UIImage(named: paymentMethods[indexPath.row].imageMethod)
            cell.methodName.text = paymentMethods[indexPath.row].nameMethod
            cell.circleView.backgroundColor = UIColor(red: 25/255, green: 94/255, blue: 242/255, alpha: 1)
        }else{
            cell.methodImage.image = UIImage(named: paymentMethods[indexPath.row].imageMethod)
            cell.methodName.text = paymentMethods[indexPath.row].nameMethod
            cell.circleView.backgroundColor = UIColor.white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0...paymentMethods.count - 1{
            if paymentMethods[i].nameMethod == paymentMethods[indexPath.row].nameMethod{
                paymentMethods[i].isSelected = true
            }else{
                paymentMethods[i].isSelected = false
            }
        }
        tableView.reloadData()
        //Use delegate to send selected payment method to BuyCoinVC
        delegate?.getPaymentMethodAndUpdate(paymentMethods[indexPath.row])
    }
}
