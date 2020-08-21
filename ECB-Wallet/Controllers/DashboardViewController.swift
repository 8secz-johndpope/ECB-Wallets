//
//  DashboardViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/21/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        //Resister Cell for collectionView
        let nibCollectionCell = UINib(nibName: "DashboardCollectionViewCell", bundle: nil)
        collectionView.register(nibCollectionCell, forCellWithReuseIdentifier: "DashboardCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

}
//MARK: - UICollectionView delegate&Datasource
extension DashboardViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashboardCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 145)
    }
}
