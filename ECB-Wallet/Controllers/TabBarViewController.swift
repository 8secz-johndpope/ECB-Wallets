//
//  DasboardVC.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/20/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    let homeButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setBackgroundImage(UIImage(named: "homeButton"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHomeButton), for: UIControl.Event.touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.delegate = self
        //Default tab
        self.selectedIndex = 2
        self.view.addSubview(homeButton)
        //
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Check safe view is available or not
        var height:CGFloat = self.tabBar.frame.size.height
        if view.safeAreaInsets.bottom > 0{
            height -= 0
        }else{
            height -= 20
        }
        // set x,y,width, height for homeButton
        homeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(height/2)).isActive = true
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
    //MARK: - Hepler Method
    @objc func handleHomeButton(){
        //Jump to DashboardVC
        self.selectedIndex = 2
    }
}
//MARK: -
extension TabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 0 {
            let dest = viewController as! WalletsViewController
            dest.backButton.isHidden = true
        }else if selectedIndex == 1 {
            let dest = viewController as! SendViewController
            dest.backButton.isHidden = true
        }else if selectedIndex == 3 {
            let dest = viewController as! RecieveViewController
            dest.backButton.isHidden = true
        }
    }
}
