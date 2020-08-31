//
//  ManageWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/31/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ManageWalletViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "ManageWalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ManageWalletTableViewCell")
        //
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
//MARK: - UITableViewDelegate&DataSource
extension ManageWalletViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageWalletTableViewCell", for: indexPath) as! ManageWalletTableViewCell
        return cell
    }
}
