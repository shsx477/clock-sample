import UIKit

class XzTriggerButton: XzRoundButton {
    
    typealias TriggerCallbackType = (UIButton) -> Void

    private static var COLOR_START_TITLE: UIColor { Const.CUSTOM_GREEN_3 }
    private static var COLOR_START_BG: UIColor { Const.CUSTOM_GREEN_2 }
    private static var COLOR_START_BG_HIGHLIGHTED: UIColor { Const.CUSTOM_GREEN_1 }
    private static var COLOR_STOP_TITLE: UIColor { Const.CUSTOM_RED_3 }
    private static var COLOR_STOP_BG: UIColor { Const.CUSTOM_RED_2 }
    private static var COLOR_STOP_BG_HIGHLIGHTED: UIColor { Const.CUSTOM_RED_1 }
    
    
    private var isStarted = false
    
    internal var didStartCallback: TriggerCallbackType?
    internal var didStopCallback: TriggerCallbackType?
    
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                super.backgroundColor = self.isStarted ? XzTriggerButton.COLOR_STOP_BG_HIGHLIGHTED : XzTriggerButton.COLOR_START_BG_HIGHLIGHTED
            } else {
                super.backgroundColor = self.isStarted ? XzTriggerButton.COLOR_STOP_BG : XzTriggerButton.COLOR_START_BG
            }
        }
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        super.addTarget(self, action: #selector(self.buttonTouchUpInside), for: .touchUpInside)
        self.updateState()
    }
    
    
    private func updateState() {
        
        var title = ""
        var titleColor = UIColor.white
        var bg = UIColor.black
        
        if self.isStarted {
            title = "중단"
            titleColor = XzTriggerButton.COLOR_STOP_TITLE
            bg = XzTriggerButton.COLOR_STOP_BG
            
        } else {
            title = "시작"
            titleColor = XzTriggerButton.COLOR_START_TITLE
            bg = XzTriggerButton.COLOR_START_BG
        }
        
        super.setTitle(title, for: .normal)
        super.setTitleColor(titleColor, for: .normal)
        super.backgroundColor = bg
    }
    
    
    @objc private func buttonTouchUpInside(_ sender: UIButton) {
        self.isStarted.toggle()
        self.updateState()
        
        if self.isStarted {
            self.didStartCallback?(self)
        } else {
            self.didStopCallback?(self)
        }
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
