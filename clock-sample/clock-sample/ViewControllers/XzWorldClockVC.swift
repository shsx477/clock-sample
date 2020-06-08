import UIKit

class XzWorldClockVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "세계 시간", image: UIImage(systemName: "globe"), tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
