import UIKit
import Foundation

class XzUtils {
    internal static func angleToRadian(angle: CGFloat) -> CGFloat { angle * (CGFloat.pi / 180) }
    
    internal static func secondsToRadianBy60Sec(seconds: TimeInterval) -> CGFloat {
        let sec = CGFloat(seconds).truncatingRemainder(dividingBy: CGFloat(XzClockConst.SECONDS_PER_MINUTE))
        let rad = sec * ((CGFloat.pi * 2) / CGFloat(XzClockConst.SECONDS_PER_MINUTE))
    
        return rad
    }
    
    internal static func calcPointOnCircle(radius: CGFloat, angle: CGFloat) -> CGPoint {
        let resultX = radius * cos(XzUtils.angleToRadian(angle: angle))
        let resultY = radius * sin(XzUtils.angleToRadian(angle: angle))
        
        return CGPoint(x: resultX, y: resultY)
    }
}
