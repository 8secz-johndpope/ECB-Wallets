//
//  SearchTransactionViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/3/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import FSCalendar
class SearchTransactionViewController: UIViewController {

    @IBOutlet weak var heightLightBlueView: NSLayoutConstraint!
    @IBOutlet weak var fromView: BoundFourCornersView!
    @IBOutlet weak var toView: BoundFourCornersView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //
    lazy var calendarFromView:FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var calendarToView:FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell for tableView
        let nibName = UINib(nibName: "WalletTransactionTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WalletTransactionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for lightBlueView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightLightBlueView.constant = tableViewHeight + 50
        // Custom segmentControl
        let titleTextAttibuteNormal =  [NSAttributedString.Key.foregroundColor:UIColor(red: 16/255, green: 0/255, blue: 54/55, alpha: 1)]
        let titleTextAttibuteSelected = [NSAttributedString.Key.foregroundColor:UIColor.white]
        segmentControl.setTitleTextAttributes(titleTextAttibuteNormal, for: UIControl.State.normal)
        segmentControl.setTitleTextAttributes(titleTextAttibuteSelected, for: UIControl.State.selected)
        segmentControl.selectedSegmentTintColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        //
        let tapFromView = UITapGestureRecognizer(target: self, action: #selector(handleTapFromView))
        self.fromView.addGestureRecognizer(tapFromView)
        //
        let tapToView = UITapGestureRecognizer(target: self, action: #selector(handleTapToView))
        self.toView.addGestureRecognizer(tapToView)
        
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchTransactionButtonWasPressed(_ sender: Any) {
    }
    @IBAction func segmentControlTransactionWasPressed(_ sender: Any) {
    }
    //MARK: Helper Method
    @objc func handleTapFromView(){
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(self.calendarFromView)
            self.calendarFromView.isHidden = false
            self.calendarFromView.delegate = self
            self.calendarFromView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
            self.calendarFromView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
            self.calendarFromView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.calendarFromView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            self.calendarFromView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            print("tap")
        }
        
    }
    @objc func handleTapToView(){
        UIView.animate(withDuration: 0.3) {
            self.view.addSubview(self.calendarToView)
            self.calendarToView.isHidden = false
            self.calendarToView.delegate = self
            self.calendarToView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
            self.calendarToView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
            self.calendarToView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.calendarToView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            self.calendarToView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            print("tap")
        }
    }
    
}
//MARK: - UITableViewDelegate and dataSource
extension SearchTransactionViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTransactionTableViewCell", for: indexPath) as! WalletTransactionTableViewCell
        return cell
    }
}
//MARK: - FSCalendarDelegate
extension SearchTransactionViewController:FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendar == calendarFromView{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: date)
            self.fromLabel.text = dateString
            UIView.animate(withDuration: 0.3) {
                self.calendarFromView.isHidden = true
            }
        }else if calendar == calendarToView{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: date)
            self.toLabel.text = dateString
            UIView.animate(withDuration: 0.3) {
                self.calendarToView.isHidden = true
            }
        }
        
    }
}
