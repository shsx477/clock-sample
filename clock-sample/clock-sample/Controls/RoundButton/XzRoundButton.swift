import UIKit

class XzRoundButton: UIButton {
    
    private var tempOriginBackground: UIColor?
    var backgroundHighlightedColor: UIColor?
    
    override var isHighlighted: Bool {
        didSet {
            if let highlightBg = self.backgroundHighlightedColor {
                if super.isHighlighted {
                    self.tempOriginBackground = super.backgroundColor
                    super.backgroundColor = highlightBg
                } else {
                    super.backgroundColor = self.tempOriginBackground
                    self.tempOriginBackground = nil
                }
            }
        }
    }

    override func draw(_ rect: CGRect) {
        self.setMask(rect)
        self.addRoundLine(rect)
    }
    
    
    private func setMask(_ rect: CGRect) {
        let halfWidth = super.frame.width / 2
        let halfHeight = super.frame.height / 2
        let maskPath = UIBezierPath(roundedRect: super.bounds,
                                    byRoundingCorners: [.allCorners],
                                    cornerRadii: CGSize(width: halfWidth, height: halfHeight))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        super.layer.mask = maskLayer
    }
    
    private func addRoundLine(_ rect: CGRect) {
        let gapOffset: CGFloat = 4
        let bdWidth = super.frame.width - (gapOffset * 2)
        let bdHeight = super.frame.height - (gapOffset * 2)
        let bdRect = CGRect(x: gapOffset, y: gapOffset, width: bdWidth, height: bdHeight)
        let bdPath = UIBezierPath(roundedRect: bdRect,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: CGSize(width: bdWidth / 2, height: bdHeight / 2))
        
        let bdLayer = CAShapeLayer()
        bdLayer.path = bdPath.cgPath
        bdLayer.lineWidth = 2
        bdLayer.strokeColor = UIColor.black.cgColor
        bdLayer.fillColor = UIColor.clear.cgColor
        super.layer.addSublayer(bdLayer)
    }
}
