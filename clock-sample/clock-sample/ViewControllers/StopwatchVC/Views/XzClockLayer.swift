import UIKit

final class XzClockLayer: CALayer {
    
    private let secondIndexCount = XzConst.SECONDS_PER_MINUTE * 4     // 1분 간격에 4개
    private let secondHandColor = UIColor(red: 250 / 255, green: 150 / 255, blue: 15 / 255, alpha: 1)
    private let TimeTextFontSize: CGFloat = 23.0
    
    private let size: CGFloat
    private let indexWidth: CGFloat
    private let indexHeight: CGFloat
    private let indexColor: UIColor
    private let minuteFontSize: CGFloat
    
    private let centerX: CGFloat
    private let centerY: CGFloat
    private let posAngle30: CGPoint
    private let posAngle60: CGPoint
    
    private var realTimeTextLayer: CATextLayer!
    private var secondHandLayer: CALayer!
    
    
    init(size: CGFloat, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor, minuteFontSize: CGFloat) {
        self.size = size
        self.indexWidth = indexWidth
        self.indexHeight = indexHeight
        self.indexColor = indexColor
        self.minuteFontSize = minuteFontSize
        
        self.centerX = size / 2
        self.centerY = size / 2
        
        let radius = (size / 2) - indexHeight
        self.posAngle30 = XzUtils.calcPointOnCircle(radius: radius, angle: 30)
        self.posAngle60 = XzUtils.calcPointOnCircle(radius: radius, angle: 60)
        
        super.init()
        
        super.frame.size.width = size
        super.frame.size.height = size
        
        
        self.setIndexSeconds()
        self.setIndexMinutes()
        self.setIndexHours()
        self.setMinuteTexts()
        
        self.realTimeTextLayer = self.setRealTimeText()
        self.secondHandLayer = self.setSecondHand()
        self.setCenterCircle()
    }
    
    
    internal func pause() {
        let pausedTime = super.convertTime(CACurrentMediaTime(), from: nil)
        super.speed = 0.0
        super.timeOffset = pausedTime
    }
    
    internal func resume() {
        let pausedTime = super.timeOffset
        super.speed = 1.0
        super.timeOffset = 0.0
        super.beginTime = 0.0
        
        let timeSincePause = super.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        super.beginTime = timeSincePause
    }
    
    internal func start(seconds: Int = 0) {
        XzClockLayer.setSecondHandAnimation(handLayer: self.secondHandLayer, seconds: seconds)
    }

    internal func reset() {
        self.secondHandLayer.removeAllAnimations()
        self.resume()
        
        self.realTimeTextLayer.string = XzConst.STOPWATCH_INIT_TIME
    }

    internal func updateTime(timeText: String) {
        self.realTimeTextLayer.string = timeText
    }
    
    
    private func setIndexSeconds() {
        let replicatorLayer = XzClockLayer.createReplicatorLayer(size: self.size, instanceCount: self.secondIndexCount)
        super.addSublayer(replicatorLayer)
        
        let idxLayer = XzClockLayer.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight / 2, indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexMinutes() {
        let replicatorLayer = XzClockLayer.createReplicatorLayer(size: self.size, instanceCount: XzConst.MINUTES_PER_HOUR)
        super.addSublayer(replicatorLayer)

        let idxLayer = XzClockLayer.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexHours() {
        let replicatorLayer = XzClockLayer.createReplicatorLayer(size: self.size, instanceCount: XzConst.HOURS_PER_DAY)
        super.addSublayer(replicatorLayer)

        let idxLayer = XzClockLayer.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: .white)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setMinuteTexts() {
        self.addMinuteText05()
        self.addMinuteText10()
        self.addMinuteText15()
        self.addMinuteText20()
        self.addMinuteText25()
        self.addMinuteText30()
        self.addMinuteText35()
        self.addMinuteText40()
        self.addMinuteText45()
        self.addMinuteText50()
        self.addMinuteText55()
        self.addMinuteText60()
    }
    
    private func setSecondHand() -> CALayer {
        let handAddLength: CGFloat = 35.0
        let handLength = (self.size / 2.0) + handAddLength
        let anchorPtY = 1.0 - (handAddLength / handLength)
        let centerX = self.size / 2
        let centerY = self.size / 2
        
        let handLayer = CALayer()
        handLayer.backgroundColor = self.secondHandColor.cgColor
        handLayer.anchorPoint = CGPoint(x: 0.5, y: anchorPtY)
        handLayer.position = CGPoint(x: centerX, y: centerY)
        handLayer.bounds = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: self.indexWidth,
                                  height: handLength)
        handLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 10.0)
        super.addSublayer(handLayer)
        
        return handLayer
    }

    private func setRealTimeText() -> CATextLayer {
        let textLayer = CATextLayer()
        let testTextLayer = CATextLayer()
        
        testTextLayer.string = "30"
        testTextLayer.font = UIFont.monospacedDigitSystemFont(ofSize: self.minuteFontSize, weight: .regular)
        let minuteTextHeight = testTextLayer.preferredFrameSize().height
        
        textLayer.string = XzConst.STOPWATCH_INIT_TIME
        textLayer.fontSize = self.TimeTextFontSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2),
                                 y: self.centerY + self.posAngle60.y - minuteTextHeight - preferredSize.height - 15.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
        
        super.addSublayer(textLayer)
        
        return textLayer
    }
    
    private func setCenterCircle() {
        let outsideCircleSize: CGFloat = 10.0
        let outsideCircleXY = self.centerX - (outsideCircleSize / 2.0)
        let insideCircleSize = outsideCircleSize / 2.0
        let insideCircleXY = self.centerX - (insideCircleSize / 2.0)
        
        let outsideCircleLayer = CAShapeLayer()
        outsideCircleLayer.frame = CGRect(x: outsideCircleXY, y: outsideCircleXY, width: outsideCircleSize, height: outsideCircleSize)
        outsideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: outsideCircleSize, height: outsideCircleSize)).cgPath
        outsideCircleLayer.fillColor = self.secondHandColor.cgColor
        super.addSublayer(outsideCircleLayer)
        
        let insideCircleLayer = CAShapeLayer()
        insideCircleLayer.frame = CGRect(x: insideCircleXY, y: insideCircleXY, width: insideCircleSize, height: insideCircleSize)
        insideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: insideCircleSize, height: insideCircleSize)).cgPath
        insideCircleLayer.fillColor = UIColor.black.cgColor
        super.addSublayer(insideCircleLayer)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK:- static functions
extension XzClockLayer {
    private static func addCATextLayer(layer: CALayer, text: String, fontSize: CGFloat) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.fontSize = fontSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
        layer.addSublayer(textLayer)
        
        return textLayer
    }
    
    private static func createReplicatorLayer(size: CGFloat, instanceCount: Int) -> CAReplicatorLayer {
        let rad = CGFloat.pi * 2.0 / CGFloat(instanceCount)
        let replicatorLayer = CAReplicatorLayer()
        
        replicatorLayer.frame =  CGRect(x: 0.0, y: 0.0, width: size, height: size)
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(rad, 0.0, 0.0, 1.0)
        
        return replicatorLayer
    }
    
    private static func createIndexLayer(size: CGFloat, indexWidth: CGFloat, indexHeight: CGFloat, indexColor: UIColor) -> CALayer {
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
    
    private static func setSecondHandAnimation(handLayer: CALayer, seconds: Int) {
        let rad = XzUtils.secondsToRadian(seconds: seconds)
        let secondsHandAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        secondsHandAnimation.repeatCount = Float.infinity
        secondsHandAnimation.duration = CFTimeInterval(XzConst.SECONDS_PER_MINUTE)
        secondsHandAnimation.isRemovedOnCompletion = false
        secondsHandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        secondsHandAnimation.fromValue = rad
        secondsHandAnimation.byValue = Double.pi * 2
        handLayer.add(secondsHandAnimation, forKey: "secondsHandAnimation")
    }
}

// MARK:- creating minute text methos
extension XzClockLayer {
    private func addMinuteText05() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "5", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle60.x - 15.0,
                                 y: self.centerY - self.posAngle60.y,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText10() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "10", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: centerX + self.posAngle30.x - 35.0,
                                 y: centerY - self.posAngle30.y - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText15() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "15", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.size - (self.indexHeight + preferredSize.width) - 8.0,
                                 y: self.centerY - (preferredSize.height / 2) + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText20() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "20", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle30.x - 40.0,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 8.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText25() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "25", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle60.x - 30.0,
                                 y: self.centerY + self.posAngle60.y - preferredSize.height - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText30() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "30", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2) - 3.0,
                                 y: self.size - (self.indexHeight + preferredSize.height) - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText35() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "35", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle60.x - 10.0,
                                 y: self.centerY + self.posAngle60.y - preferredSize.height - 5.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText40() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "40", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 5.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText45() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "45", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.indexHeight + 8.0,
                                 y: self.centerY - (preferredSize.height / 2) - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText50() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "50", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x + 3.0,
                                 y: self.centerY - self.posAngle30.y - 10.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText55() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "55", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: centerX - self.posAngle60.x - 5.0,
                                 y: centerY - self.posAngle60.y,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText60() {
        let textLayer = XzClockLayer.addCATextLayer(layer: self, text: "60", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2) + 3.0,
                                 y: self.indexHeight + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
}
