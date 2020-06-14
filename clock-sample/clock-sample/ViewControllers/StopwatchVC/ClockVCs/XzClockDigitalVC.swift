import UIKit

class XzClockDigitalVC: UIViewController {

    private let lb_clock = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = self.lb_clock
        lb.text = XzClockConst.STOPWATCH_INIT_TIME
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
    
    
    internal func updateTime(elapsedSecText: String) {
        self.lb_clock.text = elapsedSecText
    }

    internal func reset() {
        self.lb_clock.text = XzClockConst.STOPWATCH_INIT_TIME
    }
}
