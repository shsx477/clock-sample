//
//  Utils.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

class Utils {
    static func createRoundedButton(title: String,
                                    titleColor: UIColor,
                                    backgroundColor: UIColor,
                                    highlightedBackgroundColor: UIColor) -> XzRoundButton {
        let btn = XzRoundButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.highlightBackgroundColor = highlightedBackgroundColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return btn
    }
}
