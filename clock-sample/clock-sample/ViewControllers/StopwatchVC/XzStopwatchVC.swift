import UIKit

class XzStopwatchVC: UIViewController {
    private let btnMargin: CGFloat = 20
    private let clockPageVC = XzClockPageVC()
    private let buttonView = UIView()
    private let lapTableVC = XzLapTableVC()
    private let btn_trigger = XzTriggerButton()
    private let btn_extra = XzExtraButton()
    
    
    private var curState = state.reset
    private var stopwatchTimer: Timer?
    private var curBeginTime: Date?
    private var oldElapsedSec = 0.0     // 마지막 경과초 (마지막에 중단했을 때 초)
    private var nowElapsedSec = 0.0     // 현재 실시간 초
    
    
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

    
    private func timerBlock(timer: Timer) {
        if let beginTime = self.curBeginTime {
            self.nowElapsedSec = Date().timeIntervalSince(beginTime) + self.oldElapsedSec

            self.clockPageVC.updateTime(elapsedSec: self.nowElapsedSec)
            self.lapTableVC.updateTime(elapsedSec: self.nowElapsedSec)
        }
    }
    
    // MARK:- actions
    
    private func doStartTrigger(_ sender: UIButton)
    {
        self.curState = .running
        self.btn_extra.setStateLap()
        
        let nowTime = Date()
        self.curBeginTime = nowTime
        
        self.clockPageVC.start()
        self.lapTableVC.start()
        
        let newTimer = Timer(timeInterval: 0.01, repeats: true, block: self.timerBlock(timer:))
        self.stopwatchTimer = newTimer
        RunLoop.current.add(newTimer, forMode: .common)
    }
    
    private func doStopTrigger(_ sender: UIButton)
    {
        self.stopwatchTimer?.invalidate()
        self.stopwatchTimer = nil
        self.oldElapsedSec = self.nowElapsedSec
        
        self.clockPageVC.stop()
        
        self.curState = .paused
        self.btn_extra.setStatePaused()
    }
    
    private func doLap(_ sender: UIButton) {
        self.lapTableVC.lap(elapsedSec: self.nowElapsedSec)
    }
    
    private func doReset(_ sender: UIButton) {
        self.curState = .reset
        self.btn_extra.setStateReset()
        
        self.oldElapsedSec = 0.0
        self.nowElapsedSec = 0.0
        self.curBeginTime = nil
        
        self.clockPageVC.reset()
        self.lapTableVC.reset()
    }
    
    
    private enum state {
        case running
        case paused
        case reset
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK:- Static
extension XzStopwatchVC {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss.SS"
        return formatter
    }()
    
    internal static let INIT_TIME = "00:00.00"
    
    
    internal class func toString(date: Date) -> String { XzStopwatchVC.dateFormatter.string(from: date) }
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
