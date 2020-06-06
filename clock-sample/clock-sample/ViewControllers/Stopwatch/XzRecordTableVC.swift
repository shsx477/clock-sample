//
//  XzStopwatchRecordVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzRecordTableVC: UITableViewController {
    
    private static let separatorColor = UIColor.white.withAlphaComponent(0.4)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.tableView.backgroundColor = .black
        super.tableView.separatorColor = XzRecordTableVC.separatorColor
    }
}
