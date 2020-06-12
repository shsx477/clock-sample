import UIKit

class XzLapTableCellVC: UITableViewCell {
    
    private static let CELL_FONTSIZE: CGFloat = 18
    internal static let CELL_ID = UUID().uuidString
    
    internal let lb_lapTime: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.monospacedDigitSystemFont(ofSize: XzLapTableCellVC.CELL_FONTSIZE, weight: .regular)
        lb.textColor = XzConstColor.COLOR_TEXT_DEFAULT
        
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        super.backgroundColor = .clear
        
        let containerView = super.contentView
        
        if let lb_title = super.textLabel {
            lb_title.font = UIFont.systemFont(ofSize: XzLapTableCellVC.CELL_FONTSIZE)
            lb_title.textColor = XzConstColor.COLOR_TEXT_DEFAULT
            
            lb_title.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lb_title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                lb_title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            ])
        }

        super.contentView.addSubview(self.lb_lapTime)
        
        let lb_lap = self.lb_lapTime
        lb_lap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb_lap.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lb_lap.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}
