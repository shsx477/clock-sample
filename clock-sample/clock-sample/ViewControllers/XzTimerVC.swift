//
//  XzTimerVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzTimerVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "timer"), tag: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
