import UIKit

class XzExtraButton: XzRoundButton {
    typealias extraCallbackType = (UIButton) -> Void
    
    private static var COLOR_EXTRA_ACTIVATED_TITLE: UIColor { UIColor.white }
    private static var COLOR_EXTRA_ACTIVATED_BG: UIColor { Const.CUSTOM_GRAY_3 }
    private static var COLOR_EXTRA_DEACTIVATED_TITLE: UIColor { Const.CUSTOM_GRAY_5 }
    private static var COLOR_EXTRA_DEACTIVATED_BG: UIColor { Const.CUSTOM_GRAY_2 }
    private static var COLOR_EXTRA_HIGHLIGHTED_BG: UIColor { Const.CUSTOM_GRAY_1 }
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                super.backgroundColor = XzExtraButton.COLOR_EXTRA_HIGHLIGHTED_BG
            } else {
                super.backgroundColor = self.isActivated ? XzExtraButton.COLOR_EXTRA_ACTIVATED_BG : XzExtraButton.COLOR_EXTRA_DEACTIVATED_BG
            }
        }
    }
    
    private var isTriggerStarted = false
    private var isActivated = false
    
    internal var didLapCallback: extraCallbackType?
    internal var didResetCallback: extraCallbackType?
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        super.addTarget(self, action: #selector(self.buttonTouchUpInside), for: .touchUpInside)
        self.updateState()
    }
    
    
    private func updateState() {
        
        var title = ""
        var titleColor = UIColor.white
        var bg = UIColor.black
        
        if self.isActivated {
            if self.isTriggerStarted {
                title = "랩"
                titleColor = XzExtraButton.COLOR_EXTRA_ACTIVATED_TITLE
                bg = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
                
            } else {
                title = "재설정"
                titleColor = XzExtraButton.COLOR_EXTRA_ACTIVATED_TITLE
                bg = XzExtraButton.COLOR_EXTRA_ACTIVATED_BG
            }
        } else {
            title = "랩"
            titleColor = XzExtraButton.COLOR_EXTRA_DEACTIVATED_TITLE
            bg = XzExtraButton.COLOR_EXTRA_DEACTIVATED_BG
        }
        
        super.setTitle(title, for: .normal)
        super.setTitleColor(titleColor, for: .normal)
        super.backgroundColor = bg
    }
    
    
    internal func setTriggerState(isStarted: Bool) {
        self.isTriggerStarted = isStarted
        self.isActivated = true
        
        self.updateState()
    }
    
    
    @objc private func buttonTouchUpInside(_ sender: UIButton) {
        if self.isActivated {
            
            if self.isTriggerStarted { // lap
                self.didLapCallback?(self)
                
            } else { // reset
                self.isActivated = false
                self.isTriggerStarted = false
                self.updateState()
                
                self.didResetCallback?(self)
            }
        }
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
