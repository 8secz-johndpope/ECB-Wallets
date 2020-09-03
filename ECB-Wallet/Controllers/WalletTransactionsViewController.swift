//
//  WalletTransactionsViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/3/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import Charts
class WalletTransactionsViewController: UIViewController {
    //MARK: Models
    let yValueSent:[ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 2.4),
        ChartDataEntry(x: 1.0, y: 2.8),
        ChartDataEntry(x: 2.0, y: 3.5),
        ChartDataEntry(x: 3.0, y: 6.4),
        ChartDataEntry(x: 4.0, y: 5.5),
        ChartDataEntry(x: 5.0, y: 2.8),
        ChartDataEntry(x: 6.0, y: 3.5),
        ChartDataEntry(x: 7.0, y: 4.8),
        ChartDataEntry(x: 8.0, y: 6.9),
        ChartDataEntry(x: 9.0, y: 5.3),
        ChartDataEntry(x: 10.0, y: 4.6),
        ChartDataEntry(x: 11.0, y: 4.7),
        ChartDataEntry(x: 12.0, y: 7.3),
    ]
    let yValueReceive:[ChartDataEntry] = [
           ChartDataEntry(x: 0.0, y: 3.4),
           ChartDataEntry(x: 1.0, y: 3.8),
           ChartDataEntry(x: 2.0, y: 2.5),
           ChartDataEntry(x: 3.0, y: 5.4),
           ChartDataEntry(x: 4.0, y: 6.5),
           ChartDataEntry(x: 5.0, y: 4.8),
           ChartDataEntry(x: 6.0, y: 4.5),
           ChartDataEntry(x: 7.0, y: 3.8),
           ChartDataEntry(x: 8.0, y: 5.9),
           ChartDataEntry(x: 9.0, y: 6.3),
           ChartDataEntry(x: 10.0, y: 5.6),
           ChartDataEntry(x: 11.0, y: 3.7),
           ChartDataEntry(x: 12.0, y: 6.3),
       ]
    @IBOutlet weak var heightLightBlueView: NSLayoutConstraint!
    @IBOutlet weak var weekButton: setBorderAndRoundCornerButton!
    @IBOutlet weak var yearButton: setBorderAndRoundCornerButton!
    @IBOutlet weak var monthButton: setBorderAndRoundCornerButton!
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    //
    lazy var lineChatView:LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.rightAxis.enabled = false
        
        chartView.leftAxis.enabled = true
        chartView.leftAxis.setLabelCount(3, force: false)
        chartView.leftAxis.labelTextColor = .clear
        chartView.leftAxis.axisLineColor = .clear
        chartView.leftAxis.gridLineDashLengths = [4,4]
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = UIColor(red: 154/255, green: 145/255, blue: 174/255, alpha: 1)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.gridColor = .clear
        chartView.animate(xAxisDuration: 2.0)
        chartView.legend.enabled = false
        
        
        return chartView
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
        segmentControll.setTitleTextAttributes(titleTextAttibuteNormal, for: UIControl.State.normal)
        segmentControll.setTitleTextAttributes(titleTextAttibuteSelected, for: UIControl.State.selected)
        segmentControll.selectedSegmentTintColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        //Add lineChartView into chartView
        lineChatView.delegate = self
        chartView.addSubview(lineChatView)
        lineChatView.topAnchor.constraint(equalTo: self.chartView.topAnchor, constant: 0).isActive = true
        lineChatView.leftAnchor.constraint(equalTo: self.chartView.leftAnchor, constant: 0).isActive = true
        lineChatView.rightAnchor.constraint(equalTo: self.chartView.rightAnchor, constant: 0).isActive = true
        lineChatView.bottomAnchor.constraint(equalTo: self.chartView.bottomAnchor, constant: 0).isActive = true
        //Import data for lineChartView
        setData()
        //Default sellected Button
        weekButton.backgroundColor = UIColor(red: 0/255, green: 81/255, blue: 255/255, alpha: 1)
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func calenderButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoSearchTransactionVC", sender: nil)
    }
    @IBAction func weekButtonWasPressed(_ sender: UIButton) {
        weekButton.backgroundColor = UIColor(red: 0/255, green: 81/255, blue: 255/255, alpha: 1)
        monthButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        yearButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
    }
    
    @IBAction func monthButtonWasPressed(_ sender: UIButton) {
        monthButton.backgroundColor = UIColor(red: 0/255, green: 81/255, blue: 255/255, alpha: 1)
        weekButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        yearButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
    }
    
    @IBAction func yearButtonWasPressed(_ sender: UIButton) {
        yearButton.backgroundColor = UIColor(red: 0/255, green: 81/255, blue: 255/255, alpha: 1)
        weekButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        monthButton.backgroundColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
    }
    
    @IBAction func refreshButtonWasPressed(_ sender: Any) {
        
    }
    @IBAction func segmentControllTransactionWasPressed(_ sender: Any) {
        
    }
    //MARK: - Helper method
    func setData(){
        let sentLine = LineChartDataSet(entries: yValueSent, label: "Sent")
        sentLine.drawCirclesEnabled = false
        sentLine.mode = .cubicBezier
        sentLine.lineWidth = 3
        sentLine.setColor(NSUIColor(red: 243/255, green: 71/255, blue: 100/255, alpha: 1), alpha: 1)
        let receiveLine = LineChartDataSet(entries: yValueReceive, label: "Receive")
        receiveLine.drawCirclesEnabled = false
        receiveLine.mode = .cubicBezier
        receiveLine.lineWidth = 3
        receiveLine.setColor(NSUIColor(red: 0/255, green: 81/255, blue: 255/55, alpha: 1))
        let data = LineChartData(dataSets: [sentLine, receiveLine])
        data.setDrawValues(false)
        lineChatView.data = data
    }
    
}

extension WalletTransactionsViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTransactionTableViewCell", for: indexPath) as! WalletTransactionTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionDetailVC = storyboard.instantiateViewController(identifier: "transactionDetailVC") as! TransactionDetailViewController
        self.present(transactionDetailVC, animated: true, completion: nil)
    }
}
extension WalletTransactionsViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //create markerView
        let marker:BalloonMarker = BalloonMarker(color: UIColor(red: 234/255, green: 246/255, blue: 255/255, alpha: 1), font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1), insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 25.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)//CGSize(75.0, 35.0)
        chartView.marker = marker
        
    }
    
}
