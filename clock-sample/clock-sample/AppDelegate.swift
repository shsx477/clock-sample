import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        if let win = self.window {
            win.backgroundColor = .black
            win.rootViewController = XzMainTabController()
            win.makeKeyAndVisible()
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if let mainTabVC = self.window?.rootViewController as? XzMainTabController {
            let mainTabChildVCs = mainTabVC.viewControllers?.compactMap { $0 as? XzMainTabChild }
            mainTabChildVCs?.forEach { $0.applicationWillTerminated() }
        }
    }
}

