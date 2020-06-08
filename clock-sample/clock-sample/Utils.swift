import UIKit

class Utils {
    static func createRoundedButton(title: String,
                                    titleColor: UIColor,
                                    backgroundColor: UIColor,
                                    highlightedBackgroundColor: UIColor) -> XzRoundButton {
        let btn = XzRoundButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.backgroundHighlightedColor = highlightedBackgroundColor
        
        
        return btn
    }
}
