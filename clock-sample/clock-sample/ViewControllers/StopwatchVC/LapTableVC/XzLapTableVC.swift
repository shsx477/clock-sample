import UIKit

class XzLapTableVC: UITableViewController {
    
    private static let COLOR_SEPARATOR = UIColor.systemGray
    
    private var lapTimes = [Date]()
    private let topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = XzLapTableVC.COLOR_SEPARATOR
        
        return separator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.lapTimes.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XzLapTableCellVC.CELL_ID, for: indexPath) as! XzLapTableCellVC
        
        cell.textLabel?.text = "랩 \(indexPath.row + 1)"
        
        return cell
    }
}

extension XzLapTableVC {
    private func setUI() {
        
        if let table = super.tableView {
            // tableview
            table.backgroundColor = .black
            table.separatorColor = XzLapTableVC.COLOR_SEPARATOR
            table.separatorInset = UIEdgeInsets.zero
            table.register(XzLapTableCellVC.self, forCellReuseIdentifier: XzLapTableCellVC.CELL_ID)
            
            // top separator
            table.tableHeaderView = self.topSeparator
            
            self.setConstraint()
        }
    }
    
    private func setConstraint() {
        
        if let table = super.tableView {
            let separator = self.topSeparator
            let contentGuide = table.contentLayoutGuide
            let frameGuide = table.frameLayoutGuide
            
            separator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                separator.topAnchor.constraint(greaterThanOrEqualTo: contentGuide.topAnchor),
                separator.topAnchor.constraint(greaterThanOrEqualTo: frameGuide.topAnchor),
                separator.centerXAnchor.constraint(equalTo: table.centerXAnchor),
                separator.widthAnchor.constraint(equalTo: table.widthAnchor),
                separator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
            ])
        }
    }
}

fileprivate struct LapInfo {
    
}
