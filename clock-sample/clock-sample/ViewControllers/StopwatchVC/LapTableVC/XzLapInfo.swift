//aaa

import UIKit

class XzLapInfo {
    var lapTime: Date
    var textColor: UIColor
    
    init(textColor: UIColor) {
        self.lapTime = Date(timeIntervalSince1970: 0)
        self.textColor = textColor
    }
}
