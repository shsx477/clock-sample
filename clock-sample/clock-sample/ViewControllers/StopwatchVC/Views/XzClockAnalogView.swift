import UIKit
import Foundation

public class XzClockAnalogView: UIView {
    private var isDrawed = false
    private var isStartedOnce = false
    private var isStartClock = false
    private var clockLayer: XzClockLayer?

    
    internal func start(seconds: Int = 0) {
        if self.isStartedOnce {
            self.clockLayer?.resume()
            
        } else {
            self.clockLayer?.start()
            self.isStartedOnce = true
        }
    }
    
    internal func stop() {
        if self.isStartedOnce {
            self.clockLayer?.pause()
        } else {
            // never
        }
    }
    
    internal func reset() {
        self.clockLayer?.reset()
        self.isStartedOnce = false
    }
    
    internal func updateTime(timeText: String, elapsedSec: TimeInterval) {
        self.clockLayer?.updateTime(timeText: timeText)
        
        if self.isStartClock {
            self.clockLayer?.start(seconds: Int(elapsedSec) % XzConst.SECONDS_PER_MINUTE)
            self.isStartClock = false
        }
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
        super.layer.addSublayer(clock)
        
        self.clockLayer = clock
        self.isStartClock = self.isStartedOnce
    }
    
    
    override public func draw(_ rect: CGRect) {
        guard !self.isDrawed else { return }
        
        self.isDrawed = true
        self.setClock(rect: rect)
    }
}
