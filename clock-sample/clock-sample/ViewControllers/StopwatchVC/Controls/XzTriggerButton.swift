import UIKit

class XzTriggerButton: XzRoundButton {
    
    typealias TriggerCallbackType = (UIButton) -> Void

    private static var COLOR_START_TITLE: UIColor { ConstColor.CUSTOM_GREEN_3 }
    private static var COLOR_START_BG: UIColor { ConstColor.CUSTOM_GREEN_2 }
    private static var COLOR_START_BG_HIGHLIGHTED: UIColor { ConstColor.CUSTOM_GREEN_1 }
    private static var COLOR_STOP_TITLE: UIColor { ConstColor.CUSTOM_RED_3 }
    private static var COLOR_STOP_BG: UIColor { ConstColor.CUSTOM_RED_2 }
    private static var COLOR_STOP_BG_HIGHLIGHTED: UIColor { ConstColor.CUSTOM_RED_1 }
    
    
    private var isWillStart = true
    
    internal var doStartCallback: TriggerCallbackType?
    internal var doStopCallback: TriggerCallbackType?
    
    
    override var isHighlighted: Bool {
        didSet {
            if super.isHighlighted {
                super.backgroundColor = self.isWillStart ? XzTriggerButton.COLOR_START_BG_HIGHLIGHTED : XzTriggerButton.COLOR_STOP_BG_HIGHLIGHTED
            } else {
                super.backgroundColor = self.isWillStart ? XzTriggerButton.COLOR_START_BG : XzTriggerButton.COLOR_STOP_BG
            }
        }
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        super.addTarget(self, action: #selector(self.buttonTouchUpInside), for: .touchUpInside)
        self.setStateWillStart()
    }
    
    
    private func setStateWillStart() {
        self.isWillStart = true
        super.setTitle("시작", for: .normal)
        super.setTitleColor(XzTriggerButton.COLOR_START_TITLE, for: .normal)
        super.backgroundColor = XzTriggerButton.COLOR_START_BG
    }
    
    private func setStateWillStop() {
        self.isWillStart = false
        super.setTitle("중단", for: .normal)
        super.setTitleColor(XzTriggerButton.COLOR_STOP_TITLE, for: .normal)
        super.backgroundColor = XzTriggerButton.COLOR_STOP_BG
    }
    
    @objc private func buttonTouchUpInside(_ sender: UIButton) {
        
        if self.isWillStart {
            self.setStateWillStop()
            self.doStartCallback?(self)
            
        } else {
            self.setStateWillStart()
            self.doStopCallback?(self)
        }
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
