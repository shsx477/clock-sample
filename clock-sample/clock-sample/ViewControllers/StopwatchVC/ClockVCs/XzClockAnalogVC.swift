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
    
    
    internal func start(seconds: Int = 0) { self.analogClockView.start(seconds: seconds) }
    
    internal func stop() { self.analogClockView.stop() }
    
    internal func reset() { self.analogClockView.reset() }
    
    internal func updateTime(timeText: String, elapsedSec: TimeInterval) { self.analogClockView.updateTime(timeText: timeText, elapsedSec: elapsedSec) }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
