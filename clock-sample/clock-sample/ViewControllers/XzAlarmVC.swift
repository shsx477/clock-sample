//
//  XzAlarmVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzAlarmVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "알람", image: UIImage(systemName: "alarm.fill"), tag: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
