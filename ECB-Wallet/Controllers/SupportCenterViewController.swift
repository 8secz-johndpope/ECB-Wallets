//
//  SupportCenterViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class SupportCenterViewController: UIViewController {

    @IBOutlet weak var contactView: SetBorderAndRoundCornerView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "SupportCenterTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SupportCenterTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapContactView))
        contactView.addGestureRecognizer(tap)
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
    
    @IBAction func backButtonwasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    //MARK: - Helper Method
    @objc func handleTapContactView(){
        self.performSegue(withIdentifier: "gotoContactVC", sender: nil)
    }
    

}
extension SupportCenterViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCenterTableViewCell", for: indexPath) as! SupportCenterTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
