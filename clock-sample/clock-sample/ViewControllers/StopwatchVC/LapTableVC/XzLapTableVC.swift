import UIKit

class XzLapTableVC: UITableViewController {
    
    private static var COLOR_SEPARATOR: UIColor { UIColor.systemGray5 }
    private static var COLOR_BEST_TEXT: UIColor { XzConstColor.CUSTOM_GREEN_3 }
    private static var COLOR_WORST_TEXT: UIColor { XzConstColor.CUSTOM_RED_3 }
    
    private let topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = XzLapTableVC.COLOR_SEPARATOR
        return separator
    }()
    
    private var lapTimeInfos = [XzLapInfo]()
    private var lb_top: UILabel?
    private var curLapInfoBest: XzLapInfo?
    private var curLapInfoWorst: XzLapInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
    }
    
    
    private func addLapTimeInfo() { self.lapTimeInfos.insert(XzLapInfo(textColor: XzConstColor.COLOR_TEXT_DEFAULT), at: 0) }
    
    
    internal func start() {
        if self.lapTimeInfos.count <= 0 {
            self.addLapTimeInfo()
            super.tableView.reloadData()
        }
    }
    
    internal func reset() {
        self.lapTimeInfos.removeAll()
        super.tableView.reloadData()
    }
    
    internal func lap(lapTime: TimeInterval) {
        self.lapTimeInfos.first?.lapTime = Date(timeIntervalSince1970: lapTime)

        if self.lapTimeInfos.count >= 2,
            let firstItem = self.lapTimeInfos.first {
            
            let lapInfoBest = self.lapTimeInfos.reduce(firstItem) { $0.lapTime < $1.lapTime ? $0 : $1 }
            let lapInfoWorst = self.lapTimeInfos.reduce(firstItem) { $0.lapTime > $1.lapTime ? $0 : $1 }
            
            if lapInfoBest !== self.curLapInfoBest {
                self.curLapInfoBest?.textColor = XzConstColor.COLOR_TEXT_DEFAULT
                lapInfoBest.textColor = XzLapTableVC.COLOR_BEST_TEXT
                self.curLapInfoBest = lapInfoBest
            }
            
            if lapInfoWorst !== self.curLapInfoWorst {
                self.curLapInfoWorst?.textColor = XzConstColor.COLOR_TEXT_DEFAULT
                lapInfoWorst.textColor = XzLapTableVC.COLOR_WORST_TEXT
                self.curLapInfoWorst = lapInfoWorst
            }
        }
        
        self.addLapTimeInfo()
        super.tableView.reloadData()
    }
    
    internal func updateTime(lapTime: TimeInterval) {
        let nowTime = Date(timeIntervalSince1970: lapTime)
        self.lb_top?.text = XzClockUtils.toString(date: nowTime)
    }
    
    internal func applicationWillTerminate() {

    }
    
    // MARK:- delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { self.lapTimeInfos.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XzLapTableCellVC.CELL_ID, for: indexPath) as! XzLapTableCellVC
        
        let lapInfo = self.lapTimeInfos[indexPath.row]
        let number = self.lapTimeInfos.count - indexPath.row
        
        if let lbTitle = cell.textLabel {
            lbTitle.text = "랩 \(number)"
            lbTitle.textColor = lapInfo.textColor
        }
        
        cell.lb_lapTime.text = XzClockUtils.toString(date: lapInfo.lapTime)
        cell.lb_lapTime.textColor = lapInfo.textColor
        
        if indexPath.row == 0 {
            self.lb_top = cell.lb_lapTime
        }
        
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
