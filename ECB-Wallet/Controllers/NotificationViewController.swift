//
//  NotificationViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/27/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var gestureRow : [NSValue: Int]  = [:]
    var gestureSession:[NSValue: Int]  = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell for tableView
        let nibName = UINib(nibName: "NotificationTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "NotificationTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
extension NotificationViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        //
        let drag = UIPanGestureRecognizer(target: self, action: #selector(cellDragged(_:)))
        drag.delegate = self
        cell.addGestureRecognizer(drag)
        let value = NSValue.init(nonretainedObject: drag)
        gestureRow[value] = indexPath.row
        gestureSession[value] = indexPath.section
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "gotoDetailNotification", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 15, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: "redCircel")
        
        let titleLabel = UILabel(frame: CGRect(x: 45, y: 10, width: 150, height: 21))
        titleLabel.font = UIFont(name: "SF Pro Display", size: 18)
        titleLabel.textColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        titleLabel.text = "06 Aug 2020"
        headerView.addSubview(imageView)
        headerView.addSubview(titleLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            //let translation = panGestureRecognizer.translation(in: superview!)
            let translation = panGestureRecognizer.translation(in: tableView)
            if abs(translation.x) > abs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    //MARK: helper method
    @objc func cellDragged(_ gesture: UIPanGestureRecognizer) {
        let key = NSValue.init(nonretainedObject: gesture)
        guard let row = gestureRow[key] else {return}
        guard let session = gestureSession[key] else {return}
        let indexPath = IndexPath(row: row, section: session)
        let cell = tableView.cellForRow(at: indexPath) as! NotificationTableViewCell
        let translation = gesture.translation(in: cell)
        if translation.x < 0 {
            UIView.animate(withDuration: 0.5) {
                cell.trailingCellConstant.constant = 50
                cell.leadingCellConstant.constant = 0
            }
            cell.trailingCellConstant.constant = 50
            cell.leadingCellConstant.constant = 0
        }else{
            UIView.animate(withDuration: 0.5) {
                cell.trailingCellConstant.constant = 0
                cell.leadingCellConstant.constant = 50
            }
        }
    }
}
