import UIKit

class XzClockPageVC: UIPageViewController {
    
    private let clockPageVCs = [XzDigitalClockVC(), XzAnalogClockVC()]
    
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = .black
        
        super.dataSource = self
        super.setViewControllers([self.clockPageVCs[0]], direction: .forward, animated: true)
    }
}

extension XzClockPageVC: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int { self.clockPageVCs.count }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int { 0 }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let curIdx = self.clockPageVCs.firstIndex(of: viewController) {
            let beforeIdx = curIdx - 1
            if beforeIdx >= 0 {
                return self.clockPageVCs[beforeIdx]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let curIdx = self.clockPageVCs.firstIndex(of: viewController) {
            let afterIdx = curIdx + 1
            if afterIdx < self.clockPageVCs.count {
                return self.clockPageVCs[afterIdx]
            }
        }
        
        return nil
    }
}
