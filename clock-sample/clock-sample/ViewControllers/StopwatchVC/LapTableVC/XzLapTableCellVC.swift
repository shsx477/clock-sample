import UIKit

class XzLapTableCellVC: UITableViewCell {
    
    internal static let CELL_ID = UUID().uuidString
    
    private let lb_lapTime: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20)
        lb.textColor = Const.COLOR_TEXT_DEFAULT
        
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        super.backgroundColor = .clear
        super.textLabel?.textColor = Const.COLOR_TEXT_DEFAULT
        
        super.contentView.addSubview(self.lb_lapTime)
        
        let lb = self.lb_lapTime
        lb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lb.centerYAnchor.constraint(equalTo: super.contentView.centerYAnchor),
            lb.trailingAnchor.constraint(equalTo: super.contentView.trailingAnchor, constant: 20),
        ])
    }
}
