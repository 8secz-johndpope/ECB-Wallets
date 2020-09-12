//
//  ListFlatViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/7/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
protocol listFlatDelegate:class {
    func getFlagCountryAndUpdate(_ flafCountry:flag)
}
class ListFlatViewController: UIViewController {
    //MARK: Models
    var listFlats = [flag]()
    var searchResult = [flag]()
    var isSearching = false
    //MARK: - UI Elements
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:listFlatDelegate?
    //MARK: UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        searchBar.delegate = self
        //Register cell for tableView
        let nibName = UINib(nibName: "ListFlatTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ListFlatTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ListFlatViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Check is searching or not
        if isSearching{
            return searchResult.count
        }else{
            return listFlats.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListFlatTableViewCell", for: indexPath) as! ListFlatTableViewCell
        let selectedIndex = defaults.integer(forKey: "isSelected")
        if isSearching{ // is searching
            cell.configCell(searchResult[indexPath.row])
            cell.isCheckImage.isHidden = true
        }else{ // not searching
            if selectedIndex == indexPath.row {
                cell.configCell(listFlats[indexPath.row])
            }else {
                cell.configCell(listFlats[indexPath.row])
                cell.isCheckImage.isHidden = true
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //save value indexPath.row by userDefault
        defaults.set(indexPath.row, forKey: "isSelected")
        //check is searching or not
        if isSearching{
            self.delegate?.getFlagCountryAndUpdate(searchResult[indexPath.row])
        }else{
            self.delegate?.getFlagCountryAndUpdate(listFlats[indexPath.row])
        }
        self.dismiss(animated: true, completion: nil)
    }
}
extension ListFlatViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            searchResult = listFlats
        }else{
            searchResult = listFlats.filter({ (flat) -> Bool in
                guard let text = searchBar.text else {return false}
                return (flat.countryName?.contains(text.capitalizingFirstLetter()))!
            })
        }
        isSearching = true
        tableView.reloadData()
    }
}
