//
//  AppDelegate.swift
//  clock-sample
//
//  Created by 한선수 on 2020/06/06.
//  Copyright © 2020 한선수. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        if let win = self.window {
            win.rootViewController = XzMainTabController()
            win.makeKeyAndVisible()
        }
        
        return true
    }
}

