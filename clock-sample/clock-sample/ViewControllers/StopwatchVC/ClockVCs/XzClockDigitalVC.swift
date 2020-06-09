import UIKit

class XzClockDigitalVC: UIViewController {

    private let lb_clock = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = self.lb_clock
        lb.text = XzStopwatchVC.INIT_TIME
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
    
    
    internal func updateTime(elapsedSec: TimeInterval) {
        self.lb_clock.text = XzStopwatchVC.toString(date: Date(timeIntervalSince1970: elapsedSec))
    }

    internal func reset() {
        self.lb_clock.text = XzStopwatchVC.INIT_TIME
    }
}
