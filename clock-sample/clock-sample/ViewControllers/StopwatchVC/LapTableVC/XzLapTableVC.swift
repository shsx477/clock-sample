//
//  XzStopwatchRecordVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzLapTableVC: UITableViewController {
    
    private static let COLOR_SEPARATOR = UIColor.systemGray
    
    private var lapTimes = [Date]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.lapTimes.count }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XzLapTableCellVC.CELL_ID, for: indexPath) as! XzLapTableCellVC
        
        cell.textLabel?.text = "랩 \(indexPath.row + 1)"
        
        return cell
    }
}

extension XzLapTableVC {
    private func setUI() {
        super.tableView.backgroundColor = .black
        super.tableView.separatorColor = XzLapTableVC.COLOR_SEPARATOR
        super.tableView.separatorInset = UIEdgeInsets.zero
        super.tableView.register(XzLapTableCellVC.self, forCellReuseIdentifier: XzLapTableCellVC.CELL_ID)
        
        let topSeparator = UIView()
        topSeparator.backgroundColor = XzLapTableVC.COLOR_SEPARATOR
        topSeparator.frame.size = CGSize(width: 0, height: 1 / UIScreen.main.scale)
        super.tableView.tableHeaderView = topSeparator
    }
}

fileprivate struct LapInfo {
    
}
