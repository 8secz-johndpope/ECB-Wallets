//
//  ListFlatViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/7/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class ListFlatViewController: UIViewController {
    //MARK: Models
    var listFlats:[flat] = [
        flat(imageUrl: "Mask Group 23", countryName: "Vietnameese"),
        flat(imageUrl: "Mask Group 23", countryName: "China"),
        flat(imageUrl: "Mask Group 23", countryName: "United State"),
        flat(imageUrl: "Mask Group 23", countryName: "Malaysia"),
    ]
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get current countryCode
        let locale: NSLocale = NSLocale.current as NSLocale
        let country: String? = locale.countryCode
        print(country ?? "no country")
        //Register cell for tableView
        let nibName = UINib(nibName: "ListFlatTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ListFlatTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }


}
extension ListFlatViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFlats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListFlatTableViewCell", for: indexPath) as! ListFlatTableViewCell
        let selectedIndex = defaults.integer(forKey: "isSelected")
        if selectedIndex == indexPath.row {
            cell.configCell(listFlats[indexPath.row])
        }else {
            cell.configCell(listFlats[indexPath.row])
            cell.isCheckImage.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        defaults.set(indexPath.row, forKey: "isSelected")
        self.dismiss(animated: true, completion: nil)
    }
}
