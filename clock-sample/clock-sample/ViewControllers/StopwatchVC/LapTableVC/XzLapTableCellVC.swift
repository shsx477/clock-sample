//
//  XzRecordTableCellVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/07.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzLapTableCellVC: UITableViewCell {
    
    
    internal static let CELL_ID = UUID().uuidString
    
    private let lb_lapTime: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = Const.COLOR_TEXT_DEFAULT
        
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        super.backgroundColor = .clear
        super.textLabel?.textColor = Const.COLOR_TEXT_DEFAULT
        
        super.contentView.addSubview(self.lb_lapTime)
        
//        let separator = UIView()
//        separator.backgroundColor = XzLapTableCellVC.COLOR_SEPARATOR
//        super.contentView.addSubview(separator)
        
        let lb = self.lb_lapTime
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.centerYAnchor.constraint(equalTo: super.contentView.centerYAnchor),
            lb.trailingAnchor.constraint(equalTo: super.contentView.trailingAnchor, constant: 20),
        ])
        
//        separator.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            separator.leadingAnchor.constraint(equalTo: super.contentView.leadingAnchor),
//            separator.trailingAnchor.constraint(equalTo: super.contentView.trailingAnchor),
//            separator.bottomAnchor.constraint(equalTo: super.contentView.bottomAnchor),
//            separator.heightAnchor.constraint(equalToConstant: 1),
//        ])
    }
}
