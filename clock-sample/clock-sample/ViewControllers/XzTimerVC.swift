import UIKit

class XzTimerVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "timer"), tag: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
