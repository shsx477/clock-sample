import UIKit

class XzClockAnalogVC: UIViewController {

    private var analogClockView = XzClockAnalogView()
    
    
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
    
    
    internal func start(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.analogClockView.start(elapsedTime: elapsedTime, lapTime: lapTime)
    }
    
    internal func stop(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.analogClockView.stop(elapsedTime: elapsedTime,
                                  lapTime: lapTime)
    }
    
    internal func reset() { self.analogClockView.reset() }
    
    internal func updateTime(elapsedTime: TimeInterval, elapsedTimeText: String, lapTime: TimeInterval? = nil) {
        self.analogClockView.updateTime(elapsedTime: elapsedTime,
                                        elapsedTimeText: elapsedTimeText,
                                        lapTime: lapTime)
    }
    
    internal func lap() { self.analogClockView.lap() }
}
