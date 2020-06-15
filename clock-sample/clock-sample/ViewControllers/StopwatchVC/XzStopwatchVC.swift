import UIKit

class XzStopwatchVC: UIViewController, XzMainTabChild {
    private let btnMargin: CGFloat = 20
    private let clockPageVC = XzClockPageVC()
    private let buttonView = UIView()
    private let lapTableVC = XzLapTableVC()
    private let btn_trigger = XzTriggerButton()
    private let btn_extra = XzExtraButton()
    
    private var stopwatchTimer: Timer?
    
    private var beginElapsedDate: Date?
    private var nowElapsedTime: TimeInterval = 0.0
    private var lastElapsedTime: TimeInterval = 0.0
    
    private var beginLapDate: Date?
    private var nowLapTime: TimeInterval = 0.0
    private var lastLapTime: TimeInterval = 0.0
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        super.tabBarItem = UITabBarItem(title: "스톱워치", image: UIImage(systemName: "stopwatch.fill"), tag: 3)
        
        self.btn_trigger.doStartCallback = self.doStartTrigger
        self.btn_trigger.doStopCallback = self.doStopTrigger
        
        self.btn_extra.doLapCallback = self.doLap
        self.btn_extra.doResetCallback = self.doReset
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    
    
    func applicationWillTerminated() {
        
    }
    
    
    private func repeatTimerBlock(timer: Timer) {
        if let beginElapsedDate = self.beginElapsedDate {
            
            let dateNow = Date()
            
            let elapsedTimeFromBegin = dateNow.timeIntervalSince(beginElapsedDate)
            let elapsedTime = elapsedTimeFromBegin + self.lastElapsedTime
            self.nowElapsedTime = elapsedTime
            
            if let beginLapDate = self.beginLapDate {
                let lapTimeFromBegin = dateNow.timeIntervalSince(beginLapDate)
                let lapTime = lapTimeFromBegin + self.lastLapTime
                self.nowLapTime = lapTime
                
                self.clockPageVC.updateTime(elapsedTime: elapsedTime,
                                            lapTime: lapTime)
                
                self.lapTableVC.updateTime(lapTime: lapTime)
                
            } else {
                self.clockPageVC.updateTime(elapsedTime: elapsedTime)
                self.lapTableVC.updateTime(lapTime: elapsedTime)
            }
        }
    }
    
    // MARK:- actions
    private func doStartTrigger(_ sender: UIButton) {
        self.btn_extra.setStateLap()
        self.lapTableVC.start()
        
        let dateNow = Date()
        self.beginElapsedDate = dateNow
        
        // set if beginLapDate set once
        if self.beginLapDate != nil {
            self.beginLapDate = dateNow
            self.clockPageVC.start(elapsedTime: self.nowElapsedTime, lapTime: self.nowLapTime)
            
        } else {
            self.clockPageVC.start(elapsedTime: self.nowElapsedTime)
        }
        
        let newTimer = Timer(timeInterval: 0.03, repeats: true, block: self.repeatTimerBlock)
        self.stopwatchTimer = newTimer
        RunLoop.current.add(newTimer, forMode: .common)
    }
    
    private func doStopTrigger(_ sender: UIButton) {
        self.stopwatchTimer?.invalidate()
        self.stopwatchTimer = nil
        
        self.lastElapsedTime = self.nowElapsedTime
        
        if self.beginLapDate != nil {
            self.lastLapTime = self.nowLapTime
            self.clockPageVC.stop(elapsedTime: self.nowElapsedTime, lapTime: self.nowLapTime)
        } else {
            self.clockPageVC.stop(elapsedTime: self.nowElapsedTime)
        }

        self.btn_extra.setStatePaused()
    }
    
    private func doLap(_ sender: UIButton) {
        if self.beginLapDate != nil {
            self.lapTableVC.lap(lapTime: self.nowLapTime)
        } else {
            self.lapTableVC.lap(lapTime: self.nowElapsedTime)
        }
        
        self.clockPageVC.lap()
        
        self.lastLapTime = 0.0
        self.beginLapDate = Date()
    }
    
    private func doReset(_ sender: UIButton) {
        self.btn_extra.setStateReset()
        
        self.nowElapsedTime = 0.0
        self.lastElapsedTime = 0.0
        self.beginElapsedDate = nil
        
        self.nowLapTime = 0.0
        self.lastLapTime = 0.0
        self.beginLapDate = nil
        
        self.clockPageVC.reset()
        self.lapTableVC.reset()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK:- UI
extension XzStopwatchVC {
    private func setUI() {
        let containerView = UIView()
        super.view.addSubview(containerView)

        containerView.addSubview(self.clockPageVC.view)
        super.addChild(self.clockPageVC)
        self.clockPageVC.didMove(toParent: self)

        self.buttonView.addSubview(self.btn_extra)
        self.buttonView.addSubview(self.btn_trigger)
        containerView.addSubview(self.buttonView)
        
        containerView.addSubview(self.lapTableVC.view)
        super.addChild(self.lapTableVC)
        
        self.setConstraint(containerView)
    }
    
    private func setConstraint(_ containerView: UIView) {

        if let tableView = self.lapTableVC.view,
            let clockPageView = self.clockPageVC.view {
            
            let space: CGFloat = 20.0
            
            let safeArea = super.view.safeAreaLayoutGuide
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: space),
                containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: space),
                containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -space),
                containerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            ])
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                tableView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.38)
            ])
            
            let btnView = self.buttonView
            btnView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                btnView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                btnView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -space),
                btnView.heightAnchor.constraint(equalToConstant: 90),
            ])
            
            let btnL = self.btn_extra
            btnL.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnL.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnL.leadingAnchor.constraint(equalTo: btnView.leadingAnchor),
                btnL.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnL.widthAnchor.constraint(equalTo: btnL.heightAnchor),
            ])

            let btnR = self.btn_trigger
            btnR.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                btnR.topAnchor.constraint(equalTo: btnView.topAnchor),
                btnR.trailingAnchor.constraint(equalTo: btnView.trailingAnchor),
                btnR.bottomAnchor.constraint(equalTo: btnView.bottomAnchor),
                btnR.widthAnchor.constraint(equalTo: btnR.heightAnchor),
            ])
            
            clockPageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                clockPageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                clockPageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                clockPageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                clockPageView.bottomAnchor.constraint(equalTo: btnView.centerYAnchor, constant: XzClockPageVC.pageControlHeight / 2),
            ])
        }
    }
}
