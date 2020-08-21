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
        button.setImage(UIImage(named: "homeButton"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Default tab
        self.selectedIndex = 2
        self.view.addSubview(homeButton)
        // set x,y,width, height for homeButton
        homeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        homeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.tabBar.frame.size.height/2 + 20)).isActive = true
    }
    



}
