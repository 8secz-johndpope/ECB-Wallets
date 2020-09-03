//
//  DetailWalletViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 9/1/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import Charts

class DetailWalletViewController: UIViewController {
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
    let listDuration = ["Day", "Week", "Month"]
    //MARK: UI Element
    @IBOutlet weak var whiteView: BoundTopLeftAndTopRightCornerView!
    @IBOutlet weak var heightLightBlueView: NSLayoutConstraint!
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var currencyUnitLabel: UILabel!
    @IBOutlet weak var valueUSDCurrencyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    //
    lazy var lineChatView:LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor.white
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.rightAxis.enabled = false
        
        chartView.leftAxis.enabled = true
        chartView.leftAxis.setLabelCount(3, force: false)
        chartView.leftAxis.labelTextColor = .clear
        chartView.leftAxis.axisLineColor = .clear
        chartView.leftAxis.gridLineDashLengths = [4,4]
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.gridColor = .clear
        chartView.animate(xAxisDuration: 2.0)
        chartView.legend.enabled = false
        
        
        return chartView
    }()
    
    let pickerViewDurarion:UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register cell for tableView
        let nibName = UINib(nibName: "DetailWalletTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "DetailWalletTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        //Get height of tableView and set height constaint for lightBlueView
        var tableViewHeight: CGFloat {
            tableView.layoutIfNeeded()
            return tableView.contentSize.height
        }
        heightLightBlueView.constant = tableViewHeight
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
        
    }
    //MARK: - UI Events
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buyButtonWasPressed(_ sender: Any) {
    }
    
    @IBAction func withdrawalButtonWasPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoWithdrawalVC", sender: nil)
    }
    
    @IBAction func sendButtonWasPressed(_ sender: Any) {
    }
    @IBAction func receiveButtonWasPressed(_ sender: Any) {
    }
    @IBAction func chooseDurationTimeButtonWasPressed(_ sender: Any) {
        pickerViewDurarion.delegate = self
        pickerViewDurarion.dataSource = self
        pickerViewDurarion.frame = CGRect(x: self.view.frame.width - 15 - 80, y: 182, width: 80, height: 120)
        pickerViewDurarion.isHidden = false
        self.whiteView.addSubview(pickerViewDurarion)
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
//MARK: UITableView Delegate and DataSource
extension DetailWalletViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWalletTableViewCell", for: indexPath) as! DetailWalletTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Jump to transactionDetailVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let transactionDetailVC = storyboard.instantiateViewController(identifier: "transactionDetailVC") as! TransactionDetailViewController
        self.present(transactionDetailVC, animated: true, completion: nil)
    }
}
extension DetailWalletViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //create markerView
        let marker:BalloonMarker = BalloonMarker(color: UIColor(red: 234/255, green: 246/255, blue: 255/255, alpha: 1), font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor(red: 16/255, green: 0/255, blue: 54/255, alpha: 1), insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 25.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)//CGSize(75.0, 35.0)
        chartView.marker = marker
        
    }
    
}
extension DetailWalletViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)
        -> Int {
        return listDuration.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listDuration[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.durationLabel.text = listDuration[row]
        pickerView.isHidden = true
        
    }
    
    
    
}
