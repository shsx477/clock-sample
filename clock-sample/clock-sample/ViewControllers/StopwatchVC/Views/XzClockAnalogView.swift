import UIKit
import Foundation

public class XzClockAnalogView: UIView {
    private typealias SELF = XzClockAnalogView
    
    private static let FONT_SIZE: CGFloat = 30.0
    private static let SECOND_INDEX_WIDTH: CGFloat = 2.0
    
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
        let idxHeight: CGFloat = 15.0
        
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
        
        SELF.setIndexSeconds(layer: super.layer, drawRect: drawRect, indexWidth: SELF.SECOND_INDEX_WIDTH, indexHeight: idxHeight / 2, indexColor: .gray)
        SELF.setIndexMinutes(layer: super.layer, drawRect: drawRect, indexWidth: SELF.SECOND_INDEX_WIDTH, indexHeight: idxHeight, indexColor: .gray)
        SELF.setIndexHours(layer: super.layer, drawRect: drawRect, indexWidth: SELF.SECOND_INDEX_WIDTH, indexHeight: idxHeight, indexColor: .white)
        SELF.setTextMinutes(layer: super.layer, drawRect: drawRect, indexHeight: idxHeight)
        SELF.setSecondHand(layer: super.layer, drawRect: drawRect, seconds: seconds, indexWidth: SELF.SECOND_INDEX_WIDTH, handColor: self.orangeColor)
        SELF.drawCenterCircle(layer: super.layer, drawRect: drawRect, fillColor: self.orangeColor)

        self.displayTextLayer = SELF.setTimeText(layer: super.layer, drawRect: drawRect, indexHeight: idxHeight)
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
            textLayer.frame = CGRect(x: centerX + xDegree60 - 15.0,
                                     y: centerY - yDegree60,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute10() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "10")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree30 - 35.0,
                                     y: centerY - yDegree30 - 3.0,
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
            textLayer.frame = CGRect(x: centerX + xDegree30 - 40.0,
                                     y: centerY + yDegree30 - size.height + 8.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute25() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "25")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX + xDegree60 - 30.0,
                                     y: centerY + yDegree60 - size.height - 3.0,
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
            textLayer.frame = CGRect(x: centerX - xDegree60 - 10.0,
                                     y: centerY + yDegree60 - size.height - 5.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute40() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "40")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree30,
                                     y: centerY + yDegree30 - size.height + 5.0,
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
            textLayer.frame = CGRect(x: centerX - xDegree30 + 3.0,
                                     y: centerY - yDegree30 - 10.0,
                                     width: size.width,
                                     height: size.height)
        }
        
        func addMinute55() {
            let textLayer = SELF.addCATextLayer(layer: layer, text: "55")
            let size = textLayer.preferredFrameSize()
            textLayer.frame = CGRect(x: centerX - xDegree60 - 5.0,
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
    
    private static func setSecondHand(layer: CALayer, drawRect: CGRect, seconds: Int, indexWidth: CGFloat, handColor: UIColor) {
        let rad = CGFloat(seconds) * CGFloat.pi / 180.0
        let handAddLength: CGFloat = 35.0
        let handLength = (drawRect.width / 2.0) + handAddLength
        let anchorPtY = 1.0 - (handAddLength / handLength)
        let centerX = drawRect.minX + (drawRect.width / 2.0)
        let centerY = drawRect.minY + (drawRect.height / 2.0)
        
        let handLayer = CALayer()
        handLayer.backgroundColor = handColor.cgColor
        handLayer.anchorPoint = CGPoint(x: 0.5, y: anchorPtY)
        handLayer.position = CGPoint(x: centerX, y: centerY)
        handLayer.bounds = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: indexWidth,
                                  height: handLength)
        handLayer.transform = CATransform3DMakeRotation(rad, 0.0, 0.0, 10.0)
        layer.addSublayer(handLayer)
        
//        SELF.setSecondHandAnimation(handLayer: handLayer, rad: rad)
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
    
    private static func setTimeText(layer: CALayer, drawRect: CGRect, indexHeight: CGFloat) -> CATextLayer {
        let centerX = drawRect.minX + (drawRect.width / 2)
        let centerY = drawRect.minY + (drawRect.height / 2)
        let radius = (drawRect.width / 2) - indexHeight
        let yDegree60 = radius * sin(SELF.toRadian(angle: 60))
        let textLayer = CATextLayer()
        
        let testTextLayer = CATextLayer()
        testTextLayer.string = "30"
        testTextLayer.font = UIFont.monospacedDigitSystemFont(ofSize: SELF.FONT_SIZE, weight: .regular)
        let minuteTextHeight = testTextLayer.preferredFrameSize().height
        
        textLayer.string = XzStopwatchVC.INIT_TIME
        textLayer.fontSize = 23
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        
        let size = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: centerX - (size.width / 2),
                                 y: centerY + yDegree60 - minuteTextHeight - size.height - 15.0,
                                 width: size.width,
                                 height: size.height)
        
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
        textLayer.fontSize = SELF.FONT_SIZE
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
//        replicatorLayer.contentsScale = UIScreen.main.scale
        
        return replicatorLayer
    }
    
    private static func createIndexLayer(drawRect: CGRect, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) -> CALayer {
        let centerX = drawRect.minX + (drawRect.width / 2)
        let idxLayer = CALayer()
                
        idxLayer.backgroundColor = indexColor.cgColor
        idxLayer.contentsScale = UIScreen.main.scale
        idxLayer.allowsEdgeAntialiasing = true
//        idxLayer.transform = CATransform3DMakeScale(0.65, 0.65, 1)
        idxLayer.frame = CGRect(x: centerX - indexWidth - 2.2,
                                y: 0.0,
                                width: indexWidth,
                                height: indexHeight)
        
        return idxLayer
    }
    
    private static func toRadian(angle: CGFloat) -> CGFloat { angle * (CGFloat.pi / 180) }
}
