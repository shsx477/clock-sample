import UIKit

class XzAlarmVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "알람", image: UIImage(systemName: "alarm.fill"), tag: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
