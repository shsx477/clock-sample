import UIKit

final class XzClockConst {
    internal static let SECONDS_PER_MINUTE = 60
    internal static let MINUTES_PER_HOUR = 60
    internal static let HOURS_PER_DAY = 12
    
    internal static let STOPWATCH_INIT_TIME = XzClockUtils.toString(date: Date(timeIntervalSince1970: 0))
    internal static let SECOND_HAND_COLOR = UIColor(red: 250 / 255, green: 150 / 255, blue: 15 / 255, alpha: 1).cgColor
    internal static let TIME_TEXT_FONTSIZE: CGFloat = 23.0
    internal static let SECOND_HAND_WIDTH: CGFloat = 2.0
}
