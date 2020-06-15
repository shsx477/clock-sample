import UIKit
import Foundation

public class XzClockAnalogView: UIView {
    private var isDrawed = false
    private var isPaused = true
    private var clockLayer: XzClockLayer?
    private var lastElapsedTime: TimeInterval?
    private var lastElapsedTimeText: String?
    private var lastLapTime: TimeInterval?
    
    
    internal func start(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.clockLayer?.start(elapsedTime: elapsedTime)

        if let tempLapTime = lapTime {
            self.clockLayer?.startLap(lapTime: tempLapTime)
        }
        
        self.isPaused = false
    }
    
    internal func stop(elapsedTime: TimeInterval, lapTime: TimeInterval? = nil) {
        self.clockLayer?.stop(elapsedTime: elapsedTime, lapTime: lapTime)
        self.isPaused = true
    }
    
    internal func reset() {
        self.clockLayer?.reset()
        self.isPaused = true
        self.lastElapsedTime = nil
        self.lastElapsedTimeText = nil
    }
    
    internal func updateTime(elapsedTime: TimeInterval, elapsedTimeText: String, lapTime: TimeInterval? = nil) {
        self.clockLayer?.updateTime(elapsedTimeText: elapsedTimeText)
        
        self.lastElapsedTime = elapsedTime
        self.lastElapsedTimeText = elapsedTimeText
        self.lastLapTime = lapTime
    }
    
    internal func lap() {
        self.clockLayer?.startLap(lapTime: 0)
    }
    
    
    private func setClock(rect: CGRect) {
        super.layer.backgroundColor = UIColor.black.cgColor

        // create clock
        var clockRect: CGRect
        
        if rect.height > rect.width {
            clockRect = CGRect(x: rect.minX,
                               y: (rect.size.height - rect.size.width) / 2,
                               width: rect.width,
                               height: rect.width)
        } else {
            clockRect = CGRect(x: (rect.size.width - rect.size.height) / 2,
                               y: rect.minY,
                               width: rect.height,
                               height: rect.height)
        }
        
        let clock = XzClockLayer(size: clockRect.width, indexWidth: 2.0, indexHeight: 15.0, indexColor: .white, minuteFontSize: 30.0)
        clock.frame = clockRect
        
        // apply current time
        if let elapsedTime = self.lastElapsedTime,
            let elapsedTimeText = self.lastElapsedTimeText {
            
            if self.isPaused {
                clock.pause(elapsedTime: elapsedTime)
            } else {
                // pass seconds that are not greater than 59
                clock.start(elapsedTime: elapsedTime.truncatingRemainder(dividingBy: TimeInterval(XzClockConst.SECONDS_PER_MINUTE)))
            }

            clock.updateTime(elapsedTimeText: elapsedTimeText)
        }
        
        // apply lap time
        if let lapTime = self.lastLapTime {
            if self.isPaused {
                clock.pauseLap(elapsedTime: lapTime)
            } else {
                clock.startLap(lapTime: lapTime)
            }
        }
        
        super.layer.addSublayer(clock)
        
        self.clockLayer = clock
    }
    
    
    override public func draw(_ rect: CGRect) {
        guard !self.isDrawed else { return }
        
        self.isDrawed = true
        self.setClock(rect: rect)
    }
}
