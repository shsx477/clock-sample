import UIKit

class ConstColor {
    static let CUSTOM_GREEN_1 = UIColor(red: 5 / 255, green: 22 / 255, blue: 9 / 255, alpha: 1)
    static let CUSTOM_GREEN_2 = UIColor(red: 9 / 255, green: 42 / 255, blue: 17 / 255, alpha: 1)
    static let CUSTOM_GREEN_3 = UIColor(red: 61 / 255, green: 206 / 255, blue: 89 / 255, alpha: 1)
    
    static let CUSTOM_RED_1 = UIColor(red: 27 / 255, green: 7 / 255, blue: 6 / 255, alpha: 1)
    static let CUSTOM_RED_2 = UIColor(red: 51 / 255, green: 14 / 255, blue: 11 / 255, alpha: 1)
    static let CUSTOM_RED_3 = UIColor(red: 255 / 255, green: 66 / 255, blue: 58 / 255, alpha: 1)
    
    static let CUSTOM_GRAY_1 = UIColor(red: 15 / 255, green: 15 / 255, blue: 16 / 255, alpha: 1)
    static let CUSTOM_GRAY_2 = UIColor(red: 28 / 255, green: 28 / 255, blue: 30 / 255, alpha: 1)
    static let CUSTOM_GRAY_3 = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    static let CUSTOM_GRAY_4 = UIColor(red: 71 / 255, green: 70 / 255, blue: 75 / 255, alpha: 1)
    static let CUSTOM_GRAY_5 = UIColor(red: 152 / 255, green: 152 / 255, blue: 159 / 255, alpha: 1)
    
    static let CUSTOM_BLUE_1 = UIColor(red: 0 / 255, green: 132 / 255, blue: 251 / 255, alpha: 1)
    static let CUSTOM_ORANGE_1 = UIColor(red: 255 / 255, green: 159 / 255, blue: 0 / 255, alpha: 1)
    
    
    static var COLOR_TEXT_DEFAULT: UIColor { UIColor.white }
    
    static var COLOR_LAP_TEXT_BEST: UIColor { CUSTOM_GREEN_3 }
    static var COLOR_LAP_TEXT_WORST: UIColor { CUSTOM_RED_3 }

    static var COLOR_CLOCK_NEEDLE: UIColor { CUSTOM_ORANGE_1 }
    static var COLOR_CLOCK_LAP_NEEDLE: UIColor { CUSTOM_BLUE_1 }
    
    static var COLOR_CLOCK_DEFAULT_INDEX: UIColor { CUSTOM_GRAY_4 }
    static var COLOR_CLOCK_HOUR_INDEX: UIColor { UIColor.white }
}
