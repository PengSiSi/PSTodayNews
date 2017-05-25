//
//  NewCareViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class NewCareViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_head_default_29x29_"), style: .plain, target: self, action: #selector(addFriendAction))
    }
}


extension NewCareViewController {
    
    func addFriendAction() {
        let addFriendVc = AddFriendViewController()
        self.navigationController?.pushViewController(addFriendVc, animated: true)
    }
}
