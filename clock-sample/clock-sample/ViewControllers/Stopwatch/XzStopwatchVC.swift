//
//  XzStopwatchVC.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class XzStopwatchVC: UIViewController {
    
    private let btnMargin: CGFloat = 20
    
    private let buttonView = UIView()
    private let recordTableVC = XzRecordTableVC()
    private let leftButton = Utils.createRoundedButton(title: "랩",
                                                       titleColor: Const.TXT_COLOR_DEACTIVATED,
                                                       backgroundColor: Const.BG_DEACTIVATED,
                                                       highlightedBackgroundColor: Const.BG_ACTIVATE_HIGHLIGHTED)
    
    private let rightButton = Utils.createRoundedButton(title: "시작",
                                                        titleColor: Const.TXT_COLOR_START,
                                                        backgroundColor: Const.BG_START,
                                                        highlightedBackgroundColor: Const.BG_START_HIGHLIGHTED)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "스톱워치", image: UIImage(systemName: "stopwatch.fill"), tag: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftButton.addTarget(self, action: #selector(self.btnLeftTouchUpInside), for: .touchDown)
        self.leftButton.addTarget(self, action: #selector(self.btnLeftTouchUpInside), for: .touchUpInside)
        self.rightButton.addTarget(self, action: #selector(self.btnRightTouchUpInside), for: .touchUpInside)
        
        self.buttonView.addSubview(self.leftButton)
        self.buttonView.addSubview(self.rightButton)
        
        super.view.addSubview(self.buttonView)
        super.view.addSubview(self.recordTableVC.view)
        
        self.setConstraint()
    }
    
    
    private func setConstraint() {
        let safeArea = super.view.safeAreaLayoutGuide

        if let tableView = self.recordTableVC.tableView {
            
            let btnView = self.buttonView
            let btnViewMargin: CGFloat = 20
            btnView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: btnViewMargin),
                btnView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -btnViewMargin),
                btnView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -btnViewMargin),
                btnView.heightAnchor.constraint(equalToConstant: 90),
            ])
            
            let btnL = self.leftButton
            btnL.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnL.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnL.leadingAnchor.constraint(equalTo: btnView.leadingAnchor),
                btnL.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnL.widthAnchor.constraint(equalTo: btnL.heightAnchor),
            ])
            
            let btnR = self.rightButton
            btnR.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnR.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnR.trailingAnchor.constraint(equalTo: btnView.trailingAnchor),
                btnR.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnR.widthAnchor.constraint(equalTo: btnR.heightAnchor),
            ])
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.37)
            ])
        }
    }
    
    // MARK:- actions
    
    @objc private func btnLeftTouchDown(_ sender: UIButton) {
        
    }
    
    @objc private func btnLeftTouchUpInside(_ sender: UIButton) {
        
    }
    
    @objc private func btnRightTouchUpInside(_ sender: UIButton) {
        
    }
}
