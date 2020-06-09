import UIKit

class XzClockDigitalVC: UIViewController {
    
    private static let INIT_TIME = "00:00.00"
    
    private let lb_clock = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = self.lb_clock
        lb.text = XzClockDigitalVC.INIT_TIME
        lb.textColor = .white
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        lb.font = UIFont.monospacedDigitSystemFont(ofSize: 80.0, weight: .thin)
        
        super.view.addSubview(lb)
        
        let safeArea = super.view.safeAreaLayoutGuide
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.topAnchor.constraint(equalTo: safeArea.topAnchor),
            lb.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            lb.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            lb.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    
    internal func updateTime(time: String) {
        self.lb_clock.text = time
    }
    
    internal func start() {
        
    }
    
    internal func stop() {
        
    }
    
    internal func reset() {
        self.lb_clock.text = XzClockDigitalVC.INIT_TIME
    }
}
