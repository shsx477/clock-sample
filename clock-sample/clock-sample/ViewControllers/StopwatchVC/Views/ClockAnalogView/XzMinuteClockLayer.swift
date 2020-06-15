import UIKit

final class XzMinuteClockLayer: CALayer {
    private static let MAX_SECONDS = XzClockConst.SECONDS_PER_MINUTE * 30
    
    private let size: CGFloat
    private let indexWidth: CGFloat
    private let indexHeight: CGFloat
    private let indexColor: UIColor
    private let minuteFontSize: CGFloat
    
    private let centerX: CGFloat
    private let centerY: CGFloat
    private let posAngle30: CGPoint
    
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
        
        super.init()
        
        super.frame.size.width = size
        super.frame.size.height = size
        
        
        self.setIndexSecondsBy30()
        self.setIndexMinutesBy1()
        self.setIndexMinutesBy30()
        self.setMinuteTexts()
        
        self.secondHandLayer = self.setSecondHand()
        self.setCenterCircle()
    }
    
    // MARK:- internal methods
    internal func start(elapsedTime: TimeInterval) {
        XzClockUtils.setSecondHandAnimation(handLayer: self.secondHandLayer,
                                            elapsedTime: elapsedTime,
                                            duration: XzMinuteClockLayer.MAX_SECONDS,
                                            key: "secondsHandAnimation")
    }
    
    internal func stop(elapsedTime: TimeInterval) {
        let rad = CGFloat(elapsedTime) * (CGFloat.pi * 2 / CGFloat(XzMinuteClockLayer.MAX_SECONDS))
        self.secondHandLayer.transform = CATransform3DMakeRotation(rad, 0.0, 0.0, 10.0)
        self.secondHandLayer.removeAllAnimations()
    }
    
    internal func reset() {
        self.secondHandLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 10.0)
        self.secondHandLayer.removeAllAnimations()
    }
    
    // MARK:- private methods
    private func setIndexSecondsBy30() {
        let indexCount = 30 * 2     // 총 30분. 1분에 2개
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: indexCount)
        super.addSublayer(replicatorLayer)
        
        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight * (2 / 3), indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexMinutesBy1() {
        let indexCount = 30     // 총 30분
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: indexCount)
        super.addSublayer(replicatorLayer)
        
        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: .systemGray3)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setIndexMinutesBy30() {
        let indexCount = 30 / 5     // 총 30분. 5분에 1개
        let replicatorLayer = XzClockUtils.createReplicatorLayer(size: self.size, instanceCount: indexCount)
        super.addSublayer(replicatorLayer)
        
        let idxLayer = XzClockUtils.createIndexLayer(size: self.size, indexWidth: self.indexWidth, indexHeight: self.indexHeight, indexColor: self.indexColor)
        replicatorLayer.addSublayer(idxLayer)
    }
    
    private func setMinuteTexts() {
        self.addMinuteText05()
        self.addMinuteText10()
        self.addMinuteText15()
        self.addMinuteText20()
        self.addMinuteText25()
        self.addMinuteText30()
    }
    
    private func setSecondHand() -> CALayer {
        let handLength = (self.size / 2.0)
        let handLayer = CALayer()
        
        handLayer.backgroundColor = XzClockConst.SECOND_HAND_COLOR
        handLayer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        handLayer.position = CGPoint(x: self.centerX, y: self.centerY)
        handLayer.bounds = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: XzClockConst.SECOND_HAND_WIDTH,
                                  height: handLength)
        handLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 10.0)
        handLayer.contentsScale = UIScreen.main.scale
        handLayer.allowsEdgeAntialiasing = true
        super.addSublayer(handLayer)
        
        return handLayer
    }
    
    private func setCenterCircle() {
        let outsideCircleSize: CGFloat = 10.0
        let outsideCircleXY = self.centerX - (outsideCircleSize / 2.0)
        let outsideCircleLayer = CAShapeLayer()
        
        outsideCircleLayer.frame = CGRect(x: outsideCircleXY, y: outsideCircleXY, width: outsideCircleSize, height: outsideCircleSize)
        outsideCircleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: outsideCircleSize, height: outsideCircleSize)).cgPath
        outsideCircleLayer.fillColor = XzClockConst.SECOND_HAND_COLOR
        super.addSublayer(outsideCircleLayer)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}

extension XzMinuteClockLayer {
    private func addMinuteText05() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "5", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle30.x - preferredSize.width - 5.0,
                                 y: self.centerY - self.posAngle30.y - 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText10() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "10", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX + self.posAngle30.x - preferredSize.width - 2.0,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText15() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "15", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2),
                                 y: self.size - self.indexHeight - preferredSize.height,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText20() {
     let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "20", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x + 1.0,
                                 y: self.centerY + self.posAngle30.y - preferredSize.height + 3.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText25() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "25", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - self.posAngle30.x + 1.0,
                                 y: self.centerY - self.posAngle30.y - 5.0,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
    
    private func addMinuteText30() {
        let textLayer = XzClockUtils.addCATextLayer(layer: self, text: "30", fontSize: self.minuteFontSize)
        let preferredSize = textLayer.preferredFrameSize()
        textLayer.frame = CGRect(x: self.centerX - (preferredSize.width / 2),
                                 y: self.indexHeight,
                                 width: preferredSize.width,
                                 height: preferredSize.height)
    }
}
