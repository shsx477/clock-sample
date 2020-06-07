//
//  XzAnalogClock.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/07.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzAnalogClockVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = UILabel()
        lb.text = "Analog Clock"
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 30)
        
        super.view.addSubview(lb)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            lb.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
        ])
    }
}
