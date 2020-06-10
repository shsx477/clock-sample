import UIKit

class XzExtraButton: XzRoundButton {
    typealias extraCallbackType = (UIButton) -> Void
    
    private static var COLOR_EXTRA_ACTIVATED_TITLE: UIColor { UIColor.white }
    private static var COLOR_EXTRA_ACTIVATED_BG: UIColor { ConstColor.CUSTOM_GRAY_3 }
    private static var COLOR_EXTRA_DEACTIVATED_TITLE: UIColor { ConstColor.CUSTOM_GRAY_5 }
    private static var COLOR_EXTRA_DEACTIVATED_BG: UIColor { ConstColor.CUSTOM_GRAY_2 }
    private static var COLOR_EXTRA_HIGHLIGHTED_BG: UIColor { ConstColor.CUSTOM_GRAY_1 }
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                super.backgroundColor = XzExtraButton.COLOR_EXTRA_HIGHLIGHTED_BG
                
            } else {
                super.backgroundColor = self.curBackground
            }
        }
    }
    
    private var curCallback: extraCallbackType?
    private var curBackground: UIColor?
    
    internal var doLapCallback: extraCallbackType?
    internal var doResetCallback: extraCallbackType?
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.setStateReset()
        super.addTarget(self, action: #selector(self.buttonTouchUpInside), for: .touchUpInside)
    }
    
    
    internal func setStateLap() {
        super.setTitle("랩", for: .normal)
        super.setTitleColor(XzExtraButton.COLOR_EXTRA_ACTIVATED_TITLE, for: .normal)
        super.backgroundColor = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
        
        self.curBackground = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
        self.curCallback = self.doLapCallback
    }
    
    internal func setStatePaused() {
        super.setTitle("재설정", for: .normal)
        super.setTitleColor(XzExtraButton.COLOR_EXTRA_ACTIVATED_TITLE, for: .normal)
        super.backgroundColor = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
        
        self.curBackground = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
        self.curCallback = self.doResetCallback
    }
    
    internal func setStateReset() {
        super.setTitle("랩", for: .normal)
        super.setTitleColor(XzExtraButton.COLOR_EXTRA_DEACTIVATED_TITLE, for: .normal)
        super.backgroundColor = XzExtraButton.COLOR_EXTRA_DEACTIVATED_BG
        
        self.curBackground = XzExtraButton.COLOR_EXTRA_DEACTIVATED_BG
        self.curCallback = nil
    }
    
    
    @objc private func buttonTouchUpInside(_ sender: UIButton) { self.curCallback?(self) }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
