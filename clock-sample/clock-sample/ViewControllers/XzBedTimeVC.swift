import UIKit

class XzBedTimeVC: UIViewController, XzMainTabChild {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "취침 시간", image: UIImage(systemName: "bed.double.fill"), tag: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func applicationWillTerminated() {
        
    }
}
