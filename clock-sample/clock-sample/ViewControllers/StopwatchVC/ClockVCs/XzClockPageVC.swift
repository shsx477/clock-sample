import UIKit

class XzClockPageVC: UIPageViewController {
    internal static let pageControlHeight: CGFloat = 37.0
    
    private let digitalClockVC = XzClockDigitalVC()
    private let analogClockVC = XzClockAnalogVC()
    private let clockPageVCs: [UIViewController]
    
    
    init() {
        self.clockPageVCs = [self.digitalClockVC, self.analogClockVC]
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = .black
        
        super.dataSource = self
        super.setViewControllers([self.clockPageVCs[0]], direction: .forward, animated: true)
    }
    
    
    internal func start(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.analogClockVC.start(elapsedTime: elapsedTime, lapTime: lapTime)
    }
    
    internal func stop(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.analogClockVC.stop(elapsedTime: elapsedTime,
                                lapTime: lapTime)
    }
    
    internal func reset() {
        self.digitalClockVC.reset()
        self.analogClockVC.reset()
    }
    
    internal func updateTime(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        let elapsedSecText = XzClockUtils.toString(date: Date(timeIntervalSince1970: elapsedTime))
        
        self.digitalClockVC.updateTime(elapsedSecText: elapsedSecText)
        self.analogClockVC.updateTime(elapsedTime: elapsedTime,
                                      elapsedTimeText: elapsedSecText,
                                      lapTime: lapTime)
    }
    
    internal func lap() { self.analogClockVC.lap() }
    
    
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
