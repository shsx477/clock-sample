import UIKit

class XzClockPageVC: UIPageViewController {
    internal static let pageControlHeight: CGFloat = 37.0
    
    private let digitalClockVC: XzClockDigitalVC
    private let analogClockVC: XzClockAnalogVC
    private let clockPageVCs: [UIViewController]
    
    
    init() {
        self.analogClockVC = XzClockAnalogVC()
        self.digitalClockVC = XzClockDigitalVC()
        self.clockPageVCs = [self.digitalClockVC, self.analogClockVC]
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = .black
        
        super.dataSource = self
        super.setViewControllers([self.clockPageVCs[0]], direction: .forward, animated: true)
    }
    
    
    internal func start() {
        
    }
    
    internal func stop() {
        
    }
    
    internal func reset() {
        self.digitalClockVC.reset()
    }
    
    internal func updateTime(elapsedSec: TimeInterval) {
        self.digitalClockVC.updateTime(elapsedSec: elapsedSec)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
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
