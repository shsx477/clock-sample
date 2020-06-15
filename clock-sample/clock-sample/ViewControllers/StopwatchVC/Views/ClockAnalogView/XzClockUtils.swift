import UIKit

internal final class XzClockUtils {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss.SS"
        return formatter
    }()
    
    
    internal static func toString(date: Date) -> String { XzClockUtils.dateFormatter.string(from: date) }
    
    internal static func createReplicatorLayer(size: CGFloat, instanceCount: Int) -> CAReplicatorLayer {
        let rad = CGFloat.pi * 2.0 / CGFloat(instanceCount)
        let replicatorLayer = CAReplicatorLayer()
        
        replicatorLayer.frame =  CGRect(x: 0.0, y: 0.0, width: size, height: size)
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(rad, 0.0, 0.0, 1.0)
        
        return replicatorLayer
    }
    
    internal static func createIndexLayer(size: CGFloat, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) -> CALayer {
        let centerX = size / 2
        let idxLayer = CALayer()
                
        idxLayer.backgroundColor = indexColor.cgColor
        idxLayer.contentsScale = UIScreen.main.scale
        idxLayer.allowsEdgeAntialiasing = true
        idxLayer.frame = CGRect(x: centerX - indexWidth / 2,
                                y: 0.0,
                                width: indexWidth,
                                height: indexHeight)
        
        return idxLayer
    }
    
    internal static func addCATextLayer(layer: CALayer, text: String, fontSize: CGFloat) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.fontSize = fontSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
        layer.addSublayer(textLayer)
        
        return textLayer
    }
    
    internal static func setSecondHandAnimation(handLayer: CALayer, elapsedTime: TimeInterval, duration: Int, key: String?) {
        let rad = CGFloat(elapsedTime) * (CGFloat.pi * 2 / (CGFloat(duration)))
        let secondsHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        secondsHandAnimation.repeatCount = Float.infinity
        secondsHandAnimation.isRemovedOnCompletion = false
        secondsHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        secondsHandAnimation.byValue = Double.pi * 2
        secondsHandAnimation.duration = CFTimeInterval(duration)
        secondsHandAnimation.fromValue = rad
        handLayer.add(secondsHandAnimation, forKey: key)
    }
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss.SSSSSS"
        return formatter
    }()
    
    internal static func pauseAnimation(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    internal static func resumeAnimation(layer: CALayer) {
        let pausedTime = layer.timeOffset
        
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePaused = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePaused
    }
}
