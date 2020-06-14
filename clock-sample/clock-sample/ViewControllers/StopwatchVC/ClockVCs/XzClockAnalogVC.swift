import UIKit

class XzClockAnalogVC: UIViewController {

    private var analogClockView = XzClockAnalogView()
    
    
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
    
    
    internal func start(seconds: TimeInterval) {
        self.analogClockView.start(seconds: seconds)
    }
    
    internal func stop(seconds: TimeInterval) { self.analogClockView.stop(seconds: seconds) }
    
    internal func reset() { self.analogClockView.reset() }
    
    internal func updateTime(elapsedSec: TimeInterval, elapsedSecText: String) {
        self.analogClockView.updateTime(elapsedSec: elapsedSec,
                                        elapsedSecText: elapsedSecText)
    }
    
    internal func lap() { self.analogClockView.lap() }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
