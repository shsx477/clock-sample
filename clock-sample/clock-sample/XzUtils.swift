import UIKit
import Foundation

class XzUtils {
    internal static func angleToRadian(angle: CGFloat) -> CGFloat { angle * (CGFloat.pi / 180) }
    
    internal static func secondsToRadian(seconds: Int) -> CGFloat { CGFloat(seconds) * ((CGFloat.pi * 2) / (CGFloat(XzConst.SECONDS_PER_MINUTE))) }
    
    internal static func calcPointOnCircle(radius: CGFloat, angle: CGFloat) -> CGPoint {
        let resultX = radius * cos(XzUtils.angleToRadian(angle: angle))
        let resultY = radius * sin(XzUtils.angleToRadian(angle: angle))
        
        return CGPoint(x: resultX, y: resultY)
    }
}
