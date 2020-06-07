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
    
    private let clockPageVC = XzClockPageVC()
    private let buttonView = UIView()
    private let recordTableVC = XzLapTableVC()
    private let btn_extra = Utils.createRoundedButton(title: "랩",
                                                      titleColor: XzStopwatchVC.COLOR_EXTRA_DEACTIVATED_TEXT,
                                                      backgroundColor: XzStopwatchVC.COLOR_EXTRA_DEACTIVATED_BG,
                                                      highlightedBackgroundColor: XzStopwatchVC.COLOR_EXTRA_HIGHLIGHTED_BG)
    
    private let btn_startStop = Utils.createRoundedButton(title: "시작",
                                                          titleColor: XzStopwatchVC.COLOR_START_TEXT,
                                                          backgroundColor: XzStopwatchVC.COLOR_START_BG,
                                                          highlightedBackgroundColor: XzStopwatchVC.COLOR_START_BG_HIGHLIGHTED)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "스톱워치", image: UIImage(systemName: "stopwatch.fill"), tag: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }

    // MARK:- actions
    
    @objc private func btnLeftTouchUpInside(_ sender: UIButton) {
        
    }
    
    @objc private func btnRightTouchUpInside(_ sender: UIButton) {
        
    }
}

// MARK:- UI
extension XzStopwatchVC {
    private static var COLOR_START_TEXT: UIColor { Const.CUSTOM_GREEN_3 }
    private static var COLOR_START_BG: UIColor { Const.CUSTOM_GREEN_2 }
    private static var COLOR_START_BG_HIGHLIGHTED: UIColor { Const.CUSTOM_GREEN_1 }

    private static var COLOR_STOP_TEXT: UIColor { Const.CUSTOM_RED_3 }
    private static var COLOR_STOP_BG: UIColor { Const.CUSTOM_RED_2 }
    private static var COLOR_STOP_BG_HIGHLIGHTED: UIColor { Const.CUSTOM_RED_1 }
    
    private static var COLOR_EXTRA_ACTIVATED_TEXT: UIColor { UIColor.white }
    private static var COLOR_EXTRA_ACTIVATED_BG: UIColor { Const.CUSTOM_GRAY_3 }
    
    private static var COLOR_EXTRA_DEACTIVATED_TEXT: UIColor { Const.CUSTOM_GRAY_5 }
    private static var COLOR_EXTRA_DEACTIVATED_BG: UIColor { Const.CUSTOM_GRAY_2 }
    
    private static var COLOR_EXTRA_HIGHLIGHTED_BG: UIColor { Const.CUSTOM_GRAY_1 }

    
    private func setUI() {
        let containerView = UIView()
        super.view.addSubview(containerView)

        containerView.addSubview(self.clockPageVC.view)
        super.addChild(self.clockPageVC)
        self.clockPageVC.didMove(toParent: self)

        self.btn_extra.addTarget(self, action: #selector(self.btnLeftTouchUpInside), for: .touchUpInside)
        self.btn_startStop.addTarget(self, action: #selector(self.btnRightTouchUpInside), for: .touchUpInside)
        self.buttonView.addSubview(self.btn_extra)
        self.buttonView.addSubview(self.btn_startStop)
        containerView.addSubview(self.buttonView)
        
        containerView.addSubview(self.recordTableVC.view)
        super.addChild(self.recordTableVC)
        
        self.setConstraint(containerView)
    }
    
    private func setConstraint(_ containerView: UIView) {

        if let tableView = self.recordTableVC.view,
            let clockPageView = self.clockPageVC.view {
            
            let space: CGFloat = 20.0
            let safeArea = super.view.safeAreaLayoutGuide
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: space),
                containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: space),
                containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -space),
                containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            ])
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                tableView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.37)
            ])
            
            let btnView = self.buttonView
            btnView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                btnView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                btnView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -space),
                btnView.heightAnchor.constraint(equalToConstant: 90),
            ])
            
            let btnL = self.btn_extra
            btnL.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnL.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnL.leadingAnchor.constraint(equalTo: btnView.leadingAnchor),
                btnL.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnL.widthAnchor.constraint(equalTo: btnL.heightAnchor),
            ])
            
            let btnR = self.btn_startStop
            btnR.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnR.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnR.trailingAnchor.constraint(equalTo: btnView.trailingAnchor),
                btnR.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnR.widthAnchor.constraint(equalTo: btnR.heightAnchor),
            ])
            
            clockPageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                clockPageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                clockPageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                clockPageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                clockPageView.bottomAnchor.constraint(equalTo: btnView.centerYAnchor),
            ])
        }
    }
}
