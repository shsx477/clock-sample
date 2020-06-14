import UIKit
import Foundation

public class XzClockAnalogView: UIView {
    private var isDrawed = false
    private var isPaused = true
    private var clockLayer: XzClockLayer?
    private var lastElapsedSec: TimeInterval?
    private var lastElapsedSecText: String?
    private var lastLappedTime: Date?
    private var lastStoppedTime: Date?
    
    
    internal func start(seconds: TimeInterval) {
        self.clockLayer?.start(seconds: seconds)

        self.isPaused = false
    }
    
    internal func stop(seconds: TimeInterval) {
        self.clockLayer?.stop(seconds: seconds)
        
        self.isPaused = true
        self.lastStoppedTime = Date()
    }
    
    internal func reset() {
        self.clockLayer?.reset()
        self.isPaused = true
        self.lastElapsedSec = nil
        self.lastElapsedSecText = nil
        self.lastLappedTime = nil
        self.lastStoppedTime = nil
    }
    
    internal func updateTime(elapsedSec: TimeInterval, elapsedSecText: String) {
        self.clockLayer?.updateTime(elapsedSecText: elapsedSecText)
        self.lastElapsedSec = elapsedSec
        self.lastElapsedSecText = elapsedSecText
    }
    
    internal func lap() {
        self.clockLayer?.lap()
        self.lastLappedTime = Date()
    }
    
    
    private func setClock(rect: CGRect) {
        super.layer.backgroundColor = UIColor.black.cgColor

        var x: CGFloat
        var y: CGFloat
        var size: CGFloat
        
        if rect.height > rect.width {
            x = rect.minX
            y = (rect.size.height - rect.size.width) / 2
            size = rect.width
        } else {
            x = (rect.size.width - rect.size.height) / 2
            y = rect.minY
            size = rect.height
        }
        
        let clock = XzClockLayer(size: size, indexWidth: 2.0, indexHeight: 15.0, indexColor: .white, minuteFontSize: 30.0)
        clock.frame = CGRect(x: x, y: y, width: size, height: size)
        
        // apply current time
        if let elapsedSec = self.lastElapsedSec,
            let elapsedSecText = self.lastElapsedSecText {
            
            if self.isPaused {
                clock.pause(elapsedSec: elapsedSec)
            } else {
                clock.start(seconds: elapsedSec.truncatingRemainder(dividingBy: TimeInterval(XzClockConst.SECONDS_PER_MINUTE)))
            }

            clock.updateTime(elapsedSecText: elapsedSecText)
        }
        
        // apply lap time
        if let lappedTime = self.lastLappedTime {
            var seconds: TimeInterval
            
            if self.isPaused {
                seconds = self.lastStoppedTime?.timeIntervalSince(lappedTime) ?? 0
            } else {
                seconds = Date().timeIntervalSince(lappedTime)
            }
            
            clock.lap(seconds: seconds)
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
