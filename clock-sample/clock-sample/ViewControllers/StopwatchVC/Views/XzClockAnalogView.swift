import UIKit
import Foundation

public class XzClockAnalogView: UIView {
    private typealias SELF = XzClockAnalogView
    
    let orangeColor = UIColor(red: 250 / 255, green: 150 / 255, blue: 15 / 255, alpha: 1)
//    let grayColor = UIColor(red: 61 / 255, green: 62 / 255, blue: 66 / 255, alpha: 1).cgColor
    
    var displayTextLayer: CATextLayer?
    var isDrawed = false

    
    override public func draw(_ rect: CGRect) {
        guard !self.isDrawed else { return }
        
//        super.backgroundColor = .systemBlue
        
        self.isDrawed = true
        self.drawClock(rect: rect)
    }

    
    private func drawClock(rect: CGRect) {
        super.layer.backgroundColor = UIColor.black.cgColor

        let seconds = 0
        let idxWidth: CGFloat = 2.0
        let idxHeight: CGFloat = 10.0
        
        var drawRect = CGRect()
        
        if rect.height > rect.width {
            drawRect.origin.x = rect.minX
            drawRect.origin.y = (rect.size.height - rect.size.width) / 2
            drawRect.size.width = rect.width
            drawRect.size.height = rect.width
        } else {
            drawRect.origin.x = (rect.size.width - rect.size.height) / 2
            drawRect.origin.y = rect.minY
            drawRect.size.width = rect.height
            drawRect.size.height = rect.height
        }
        
        SELF.setIndexSeconds(layer: super.layer, drawRect: drawRect, indexWidth: idxWidth, indexHeight: idxHeight / 2, indexColor: .gray)
        SELF.setIndexMinutes(layer: super.layer, drawRect: drawRect, indexWidth: idxWidth, indexHeight: idxHeight, indexColor: .gray)
        SELF.setIndexHours(layer: super.layer, drawRect: drawRect, indexWidth: idxWidth, indexHeight: idxHeight, indexColor: .white)
        SELF.setTextMinutes(layer: super.layer, drawRect: drawRect, indexHeight: idxHeight)
        SELF.setSecondHand(layer: super.layer, drawRect: drawRect, seconds: seconds, handColor: self.orangeColor)
        SELF.drawCenterCircle(layer: super.layer, drawRect: drawRect, fillColor: self.orangeColor)

        self.displayTextLayer = SELF.setTimeText(layer: super.layer, drawRect: drawRect)
    }
    
    
    private static func setIndexSeconds(layer: CALayer, drawRect: CGRect, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) {
        let idxCntPerMninute = 4
        let totalSecIdxCnt = Int(Const.secondsPerMinute * idxCntPerMninute)
        
        let replicatorLayer = SELF.createReplicatorLayer(drawRect: drawRect, instanceCount: totalSecIdxCnt)
        layer.addSublayer(replicatorLayer)
        
        let idxLayer = SELF.createIndexLayer(drawRect: drawRect, indexWidth: indexWidth, indexHeight: indexHeight, indexColor: indexColor)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private static func setIndexMinutes(layer: CALayer, drawRect: CGRect, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) {
        let replicatorLayer = SELF.createReplicatorLayer(drawRect: drawRect, instanceCount: Const.minutesPerHour)
        layer.addSublayer(replicatorLayer)

        let idxLayer = SELF.createIndexLayer(drawRect: drawRect, indexWidth: indexWidth, indexHeight: indexHeight, indexColor: indexColor)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private static func setIndexHours(layer: CALayer, drawRect: CGRect, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) {
        let replicatorLayer = SELF.createReplicatorLayer(drawRect: drawRect, instanceCount: Const.hoursPerDay)
        layer.addSublayer(replicatorLayer)

        let idxLayer = SELF.createIndexLayer(drawRect: drawRect, indexWidth: indexWidth, indexHeight: indexHeight, indexColor: indexColor)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private static func setTextMinutes(layer: CALayer, drawRect: CGRect, indexHeight: CGFloat) {
        let centerX = drawRect.minX + drawRect.width / 2
        let centerY = drawRect.minY + drawRect.width / 2
        let radius = (drawRect.width / 2) - indexHeight
        let xDegree60 = radius * cos(SELF.toRadian(angle: 60))
        let yDegree60 = radius * sin(SELF.toRadian(angle: 60))
        let xDegree30 = radius * cos(SELF.toRadian(angle: 30))
        let yDegree30 = radius * sin(SELF.toRadian(angle: 30))

        func addMinute60() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "60")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - (size.width / 2) + 3.0,
                                       y: indexHeight + 3.0,
                                       width: size.width,
                                       height: size.height)
        }
        
        func addMinute05() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "5")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree60,
                                     y: centerY - yDegree60,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute10() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "10")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree30,
                                     y: centerY - yDegree30,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute15() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "15")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: drawRect.maxX - (indexHeight + size.width) - 8.0,
                                     y: centerY - (size.height / 2) + 3.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute20() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "20")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree30,
                                     y: centerY + yDegree30,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute25() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "25")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree60,
                                     y: centerY + yDegree60,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute30() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "30")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - (size.width / 2) - 3.0,
                                     y: drawRect.maxY - (indexHeight + size.height) - 3.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute35() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "35")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree60,
                                     y: centerY + yDegree60,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute40() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "40")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree30,
                                     y: centerY + yDegree30,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute45() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "45")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: indexHeight + 8.0,
                                     y: centerY - (size.height / 2) - 3.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute50() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "50")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree30,
                                     y: centerY - yDegree30,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute55() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "55")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree60,
                                     y: centerY - yDegree60,
                                     width: size.width,
                                     height: size.height)
        }
        
        addMinute60()
        addMinute05()
        addMinute10()
        addMinute15()
        addMinute20()
        addMinute25()
        addMinute30()
        addMinute35()
        addMinute40()
        addMinute45()
        addMinute50()
        addMinute55()
    }
    
    private static func setSecondHand(layer: CALayer, drawRect: CGRect, seconds: Int, handColor: UIColor) {
        let rad = CGFloat(seconds) * CGFloat.pi / 180
        let handAddLength: CGFloat = 40
        let handLength = (drawRect.width / 2.0) + handAddLength
        let anchorPtY = 1 - (handAddLength / handLength)
        let centerX = drawRect.minX + (drawRect.width / 2.0)
        let centerY = drawRect.minY + (drawRect.height / 2.0)
        
        let handLayer = CALayer()
        handLayer.backgroundColor = handColor.cgColor
        handLayer.anchorPoint = CGPoint(x: 0.5, y: anchorPtY)
        handLayer.position = CGPoint(x: centerX, y: centerY)
        handLayer.bounds = CGRect(x: 0, y: 0, width: 3, height: handLength)
        handLayer.transform = CATransform3DMakeRotation(rad, 0.0, 0.0, 10.0)
        layer.addSublayer(handLayer)
        
        SELF.setSecondHandAnimation(handLayer: handLayer, rad: rad)
    }
    
    private static func setSecondHandAnimation(handLayer: CALayer, rad: CGFloat) {
        let secondsHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        secondsHandAnimation.repeatCount = Float.infinity
        secondsHandAnimation.duration = CFTimeInterval(Const.secondsPerMinute)
        secondsHandAnimation.isRemovedOnCompletion = false
        secondsHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        secondsHandAnimation.fromValue = rad
        secondsHandAnimation.byValue = Double.pi * 2
        handLayer.add(secondsHandAnimation, forKey: "secondsHandAnimation")
    }
    
    private static func setTimeText(layer: CALayer, drawRect: CGRect) -> CATextLayer {
        let centerX = drawRect.minX + (drawRect.width / 2)
        let centerY = drawRect.minY + (drawRect.height / 2)
        let textLayer = CATextLayer()
        
        textLayer.frame = CGRect(x: centerX - 43, y: centerY + 60, width: 150, height: 50)
        textLayer.string = "00:00.00"
        textLayer.fontSize = 23
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(textLayer)
        
        return textLayer
    }
    
    private static func drawCenterCircle(layer: CALayer, drawRect: CGRect, fillColor: UIColor) {
        let centerX = drawRect.minX + (drawRect.width / 2)
        let centerY = drawRect.minY + (drawRect.height / 2)
        let outsideCircleSize: CGFloat = 10.0
        let outsideCircleX = centerX - (outsideCircleSize / 2)
        let outsideCircleY = centerY - (outsideCircleSize / 2)
        let insideCircleSize = outsideCircleSize / 2
        let insideCircleX = centerX - (insideCircleSize / 2)
        let insideCircleY = centerY - (insideCircleSize / 2)
        
        let outsideCircleLayer = CAShapeLayer()
        outsideCircleLayer.frame = CGRect(x: outsideCircleX, y: outsideCircleY, width: outsideCircleSize, height: outsideCircleSize)
        outsideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: outsideCircleSize, height: outsideCircleSize)).cgPath
        outsideCircleLayer.fillColor = fillColor.cgColor
        layer.addSublayer(outsideCircleLayer)
        
        let insideCircleLayer = CAShapeLayer()
        insideCircleLayer.frame = CGRect(x: insideCircleX, y: insideCircleY, width: insideCircleSize, height: insideCircleSize)
        insideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: insideCircleSize, height: insideCircleSize)).cgPath
        insideCircleLayer.fillColor = UIColor.black.cgColor
        layer.addSublayer(insideCircleLayer)
    }
    
    
    func pauseAnimation(){
        let pausedTime = super.layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeAnimation(){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime

        layer.beginTime = timeSincePause
    }
    
    // MARK:- common
    
    private static func addCATextLayer(layer: CALayer, text: String) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.fontSize = 30
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
        layer.addSublayer(textLayer)
        
        return textLayer
    }
    
    private static func createReplicatorLayer(drawRect: CGRect, instanceCount: Int) -> CAReplicatorLayer {
        let rad = CGFloat.pi * 2.0 / CGFloat(instanceCount)
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame =  drawRect
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(rad, 0.0, 0.0, 1.0)
        
        return replicatorLayer
    }
    
    private static func createIndexLayer(drawRect: CGRect, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) -> CALayer {
        let centerX = drawRect.minX + (drawRect.width / 2)
        let idxLayer = CALayer()
        idxLayer.frame = CGRect(x: centerX - (indexWidth / 2.0), y: 0.0, width: indexWidth, height: indexHeight)
        idxLayer.backgroundColor = indexColor.cgColor
        idxLayer.contentsScale = UIScreen.main.scale
        
        return idxLayer
    }
    
    private static func toRadian(angle: CGFloat) -> CGFloat { angle * (CGFloat.pi / 180) }
}
