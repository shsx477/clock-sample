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
        let centerX = drawRect.width / 2
        let centerY = drawRect.minY + drawRect.width / 2
        let widthSize: CGFloat = 80
        let heightSize: CGFloat = 80

//        let y0 = drawRect.minY + indexHeight
        let y0: CGFloat = 0
        let y1 = drawRect.minY + 45
        let y2 = drawRect.minY + 95
        let y3 = centerY - 20
        let y4 = centerY + 50
        let y5 = centerY + 107
        let y6 = drawRect.height - indexHeight - 5 - 40
        
        let x0 = indexHeight + 3
        let x1: CGFloat = 50
        let x2: CGFloat = 100
        let x3          = centerX - 15
        let x4          = centerX + 55
        let x5          = centerX + 110
        
        let frame60 = CGRect(x: x3, y: y0, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "60", frame: frame60)
        
        let frame5 = CGRect(x: x4 + 5, y: y1, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "5", frame: frame5)
     
        let frame10 = CGRect(x: x5, y: y2, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "10", frame: frame10)
        
        let frame15 = CGRect(x: drawRect.width - 60, y: y3, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "15", frame: frame15)
        
        let frame20 = CGRect(x: x5, y: y4, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "20", frame: frame20)
        
        let frame25 = CGRect(x: x4, y: y5, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "25", frame: frame25)
        
        let frame30 = CGRect(x: x3, y: y6, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "30", frame: frame30)
        
        let frame35 = CGRect(x: x2, y: y5, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "35", frame: frame35)
        
        let frame40 = CGRect(x: x1, y: y4, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "40", frame: frame40)
        
        let frame45 = CGRect(x: x0, y: y3, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "45", frame: frame45)
        
        let frame50 = CGRect(x: x1, y: y2, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "50", frame: frame50)
        
        let frame55 = CGRect(x: x2, y: y1, width: widthSize, height: heightSize)
        XzClockAnalogView.addCATextLayer(layer: layer, text: "55", frame: frame55)
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
    
    private static func addCATextLayer(layer: CALayer, text: String, frame: CGRect) {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.string = text
        textLayer.fontSize = 30
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.backgroundColor = UIColor.systemBlue.cgColor
        
        layer.addSublayer(textLayer)
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
}
