import UIKit

class XzMainTabController: UITabBarController {
    
    private let tabBarSelectedColor = UIColor(red: 252 / 255, green: 150 / 255, blue: 15 / 255, alpha: 1)
    private let tabBarBgColor = UIColor(red: 20 / 255, green: 20 / 255, blue: 20 / 255, alpha: 1)
    
    
    override func viewDidLoad() {
        let vc0 = XzWorldClockVC()
        let vc1 = XzAlarmVC()
        let vc2 = XzBedTimeVC()
        let vc3 = XzStopwatchVC()
        let vc4 = XzTimerVC()
        
        super.setViewControllers([vc0, vc1, vc2, vc3, vc4], animated: true)
        
        super.tabBar.barTintColor = self.tabBarBgColor
        super.tabBar.tintColor = self.tabBarSelectedColor
    }
}
