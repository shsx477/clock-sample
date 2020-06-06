//
//  XzBedTimeVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzBedTimeVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "취침 시간", image: UIImage(systemName: "bed.double.fill"), tag: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
