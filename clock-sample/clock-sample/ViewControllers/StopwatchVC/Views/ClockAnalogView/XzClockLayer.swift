import UIKit

final class XzClockLayer: CALayer {
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
    private var lapSecondHandLayer: CALayer!
    private var minuteClockLayer: XzMinuteClockLayer!
    
    
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
        
        
        self.setIndexMilliSecondsBy250()
        self.setIndexSecondsBy1()
        self.setIndexSecondsBy5()
        self.setMinuteTexts()
        
        self.minuteClockLayer = self.setMinuteClockLayer()
        self.realTimeTextLayer = self.setRealTimeText()
        
        self.secondHandLayer = self.createSecondHand(handColor: XzClockConst.SECOND_HAND_COLOR)
        super.addSublayer(self.secondHandLayer)
        
        self.lapSecondHandLayer = self.createSecondHand(handColor: UIColor.systemBlue.cgColor)
        self.lapSecondHandLayer.isHidden = true
        super.addSublayer(self.lapSecondHandLayer)
        
        self.setCenterCircle()
    }
    
    
    // MARK:- internal methos
    internal func start(elapsedTime: TimeInterval) {
        XzClockUtils.setSecondHandAnimation(handLayer: self.secondHandLayer,
                                            elapsedTime: elapsedTime,
                                            duration: XzClockConst.SECONDS_PER_MINUTE,
                                            key: "secondsHandAnimation")
        self.minuteClockLayer.start(elapsedTime: elapsedTime)
    }
    
    internal func startLap(lapTime: TimeInterval) {
        self.lapSecondHandLayer.isHidden = false
        self.lapSecondHandLayer.removeAllAnimations()
        
        XzClockUtils.setSecondHandAnimation(handLayer: self.lapSecondHandLayer,
                                            elapsedTime: lapTime,
                                            duration: XzClockConst.SECONDS_PER_MINUTE,
                                            key: "lapSecondsHandAnimation")
    }
    
    internal func stop(elapsedTime: TimeInterval, lapTime: TimeInterval?) {
        XzClockUtils.pauseAnimation(layer: self)
        
        let elapsedTimeRad = XzUtils.secondsToRadianBy60Sec(seconds: elapsedTime)
        self.secondHandLayer.transform = CATransform3DMakeRotation(elapsedTimeRad, 0.0, 0.0, 10.0)
        self.secondHandLayer.removeAllAnimations()
        
        if let tempLapTime = lapTime {
            let lapTimeRad = XzUtils.secondsToRadianBy60Sec(seconds: tempLapTime)
            self.lapSecondHandLayer.transform = CATransform3DMakeRotation(lapTimeRad, 0.0, 0.0, 10.0)
            self.lapSecondHandLayer.removeAllAnimations()
        }
        
        self.minuteClockLayer.stop(elapsedTime: elapsedTime)
        
        XzClockUtils.resumeAnimation(layer: self)
    }
    
    internal func reset() {
        self.secondHandLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 10.0)
        self.secondHandLayer.removeAllAnimations()
        
        XzClockUtils.resumeAnimation(layer: self)
        self.lapSecondHandLayer.isHidden = true
        self.realTimeTextLayer.string = XzClockConst.STOPWATCH_INIT_TIME
        self.minuteClockLayer.reset()
    }
    
    internal func pause(elapsedTime: TimeInterval) {
        let rad = XzUtils.secondsToRadianBy60Sec(seconds: elapsedTime)
        self.secondHandLayer.transform = CATransform3DMakeRotation(rad, 0.0, 0.0, 10.0)
    }
    
    internal func pauseLap(elapsedTime: TimeInterval) {
        let rad = XzUtils.secondsToRadianBy60Sec(seconds: elapsedTime)
        self.lapSecondHandLayer.transform = CATransform3DMakeRotation(rad, 0.0, 0.0, 10.0)
        self.lapSecondHandLayer.isHidden = false
    }
    
    internal func updateTime(elapsedTimeText: String) {
        self.realTimeTextLayer.string = elapsedTimeText
    }
    
    // MARK:- private methos
    private func setIndexMilliSecondsBy250() {
        let indexCount = XzClockConst.SECONDS_PER_MINUTE * 4     // 1초에 4개
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: indexCount)
        super.addSublayer(replicatorLayer)
        
        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight / 2, indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexSecondsBy1() {
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: XzClockConst.MINUTES_PER_HOUR)
        super.addSublayer(replicatorLayer)

        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexSecondsBy5() {
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: XzClockConst.HOURS_PER_DAY)
        super.addSublayer(replicatorLayer)

        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: .white)
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
    
    private func createSecondHand(handColor: CGColor) -> CALayer {
        let handAddLength: CGFloat = 35.0
        let handLength = (self.size / 2.0) + handAddLength
        let anchorPtY = 1.0 - (handAddLength / handLength)
        let handLayer = CALayer()
        
        handLayer.backgroundColor = handColor
        handLayer.anchorPoint = CGPoint(x: 0.5, y: anchorPtY)
        handLayer.position = CGPoint(x: self.centerX, y: self.centerY)
        handLayer.bounds = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: XzClockConst.SECOND_HAND_WIDTH,
                                  height: handLength)
        handLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 10.0)
        handLayer.contentsScale = UIScreen.main.scale
        handLayer.allowsEdgeAntialiasing = true
        
        return handLayer
    }

    private func setRealTimeText() -> CATextLayer {
        let textLayer = CATextLayer()
        let testTextLayer = CATextLayer()
        
        testTextLayer.string = "30"
        testTextLayer.font = UIFont.monospacedDigitSystemFont(ofSize: self.minuteFontSize, weight: .regular)
        let minuteTextHeight = testTextLayer.preferredFrameSize().height
        
        textLayer.string = XzClockConst.STOPWATCH_INIT_TIME
        textLayer.fontSize = XzClockConst.TIME_TEXT_FONTSIZE
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
        let insideCircleLayer = CAShapeLayer()
        
        outsideCircleLayer.frame = CGRect(x: outsideCircleXY, y: outsideCircleXY, width: outsideCircleSize, height: outsideCircleSize)
        outsideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: outsideCircleSize, height: outsideCircleSize)).cgPath
        outsideCircleLayer.fillColor = XzClockConst.SECOND_HAND_COLOR
        super.addSublayer(outsideCircleLayer)
        
        insideCircleLayer.frame = CGRect(x: insideCircleXY, y: insideCircleXY, width: insideCircleSize, height: insideCircleSize)
        insideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: insideCircleSize, height: insideCircleSize)).cgPath
        insideCircleLayer.fillColor = UIColor.black.cgColor
        super.addSublayer(insideCircleLayer)
    }
    
    private func setMinuteClockLayer() -> XzMinuteClockLayer {
        let size = (self.size / 2) * (2.0 / 3.7)
        let clockLayer = XzMinuteClockLayer(size: size, indexWidth: self.indexWidth / 1.5, indexHeight: self.indexHeight / 2, indexColor: .white, minuteFontSize: 15.0)
        
        clockLayer.frame = CGRect(x: (self.size / 2) - (size / 2),
                                  y: size / 2 + 15.0,
                                  width: size,
                                  height: size)
        super.addSublayer(clockLayer)
        
        return clockLayer
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

// MARK:- creat minute text methods
extension XzClockLayer {
    private func addMinuteText05() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "5", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle60.x - 15.0,
                                 y: self.centerY - self.posAngle60.y,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText10() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "10", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: centerX + self.posAngle30.x - 35.0,
                                 y: centerY - self.posAngle30.y - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText15() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "15", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.size - (self.indexHeight + preferredSize.width) - 8.0,
                                 y: self.centerY - (preferredSize.height / 2) + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText20() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "20", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle30.x - 40.0,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 8.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText25() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "25", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle60.x - 30.0,
                                 y: self.centerY + self.posAngle60.y - preferredSize.height - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText30() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "30", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2) - 3.0,
                                 y: self.size - (self.indexHeight + preferredSize.height) - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText35() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "35", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle60.x - 10.0,
                                 y: self.centerY + self.posAngle60.y - preferredSize.height - 5.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText40() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "40", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 5.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText45() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "45", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.indexHeight + 8.0,
                                 y: self.centerY - (preferredSize.height / 2) - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText50() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "50", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x + 3.0,
                                 y: self.centerY - self.posAngle30.y - 10.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText55() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "55", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: centerX - self.posAngle60.x - 5.0,
                                 y: centerY - self.posAngle60.y,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText60() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "60", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2),
                                 y: self.indexHeight + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
}
