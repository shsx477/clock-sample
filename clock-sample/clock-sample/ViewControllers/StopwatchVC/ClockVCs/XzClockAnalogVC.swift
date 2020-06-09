import UIKit

class XzClockAnalogVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = UILabel()
        lb.text = "Analog Clock"
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 30)
        
        super.view.addSubview(lb)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            lb.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
        ])
    }
    
    
    internal func start() {
        
    }
    
    internal func stop() {
        
    }
    
    internal func reset() {
        
    }
}
