import UIKit

class XzDigitalClockVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = UILabel()
        lb.text = "Digital Clock"
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 30)
        
        super.view.addSubview(lb)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            lb.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
        ])
    }
}
//
