//
//  ViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/17/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {
    var currentPageNumber = 0
    // MARK: - Model
    let pages:[Page] = {
        let page1 = Page(image: "Mask Group 36", title: "Welcome, ECB Wallet", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ")
        let page2 = Page(image: "Mask Group 36", title: "What's on ECB Wallets ?", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ")
        let page3 = Page(image: "Mask Group 36", title: "Utilities of ECB Wallets ?", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ")
        return [page1, page2, page3]
    }()
    // MARK: - UI elements
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    // MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        //Custom collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        //Register collectionViewCell
        let nibCell = UINib(nibName: "WelcomeCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "WelcomeCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // MARK: - UI Events
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        if pageControll.currentPage == pages.count - 1 {
            print("we are on last page")
            // jump to startViewController
            performSegue(withIdentifier: "goToStartView", sender: nil)
        }else{
            let indexPath = IndexPath(row: pageControll.currentPage + 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            pageControll.currentPage += 1
        }
    }
    
}
// MARK: - UICollectionView Delegate & DataSource
extension WelcomeController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCell", for: indexPath) as! WelcomeCollectionViewCell
        cell.configureCell(with: pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        currentPageNumber = pageNumber
        pageControll.currentPage = currentPageNumber
        print(pageNumber)
    }
}

