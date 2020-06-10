import UIKit

class XzClockAnalogVC: UIViewController {

    private let analogClockView = XzClockAnalogView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let clock = self.analogClockView
        super.view.addSubview(clock)
        
        let safeArea = super.view.safeAreaLayoutGuide
        clock.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clock.topAnchor.constraint(equalTo: safeArea.topAnchor),
            clock.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            clock.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            clock.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    
    internal func start() {
        
    }
    
    internal func stop() {
        
    }
    
    internal func reset() {
        
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
