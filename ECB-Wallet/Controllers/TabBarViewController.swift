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
        //Default tab
        self.selectedIndex = 2
        self.view.addSubview(homeButton)
        var height:CGFloat = self.tabBar.frame.size.height
        //Check safe view is available or not
        if view.safeAreaInsets.bottom > 0 {
            height = height + 30
        }else {
            height += 20
        }
        // set x,y,width, height for homeButton
        homeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(height/2)).isActive = true
    }
    //MARK: - Hepler Method
    @objc func handleHomeButton(){
        //Jump to DashboardVC
        self.selectedIndex = 2
    }



}
