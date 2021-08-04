import UIKit

public struct SPMenuConfig {
    public var bgColor: UIColor = .white
    public var maxWidth: CGFloat = 250
    public var rowHeight = 30
    
    public init() {
        
    }
}

public struct SPMenuData<T> {
    public init(title: String?, data: T) {
        self.title = title
        self.data = data
    }
    public var title: String?
    public var data: T
}


open class SPMenu<T>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dim = UIView(frame: CGRect.zero)
    open var selector: UITableView?
    var offset: CGPoint?
    var items:[SPMenuData<T>]?
    
    open var selectItem:((T?)->Void)?
    
    open var updateHeight:((CGFloat)->())?
    
    open var height:CGFloat = 0
    
    open var config: SPMenuConfig?
    
    public convenience init(target: UIView, config: SPMenuConfig? = nil) {
        let origin = target.frame.origin
        let x = origin.x
        let y = origin.y + target.frame.size.height
        
        self.init(frame: target.frame)
        self.offset = CGPoint(x: x, y: y)
        self.config = config
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func drawBackground() {
        dim.frame = self.frame
        dim.backgroundColor = .clear
        dim.alpha = 0.2
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        dim.addGestureRecognizer(ges)
        
        self.addSubview(dim)
    }
    
    public func reloadData(data: [SPMenuData<T>]) {
        self.items = data
        self.selector?.reloadData()
        
        if let cnt = items?.count {
            height = CGFloat(44 * cnt)
            selector?.frame = CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: height)
            updateHeight?(height)
        }
    }
    
    private func drawMenu() {
        selector = UITableView(frame: CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: 200))
        if let m = selector {
            self.addSubview(m)
        }
        
        selector?.delegate = self
        selector?.dataSource = self
        
        selector?.alwaysBounceVertical = false
    }
    
    private func setup() {
        config = SPMenuConfig()
        drawBackground()
        drawMenu()
    }
    
    @objc private func tapHandler() {
        self.selector?.clearConstraints()
        self.removeFromSuperview()
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = config?.bgColor
        cell.textLabel?.text = self.items?[indexPath.row].title
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selector?.deselectRow(at: indexPath, animated: true)
        self.selectItem?(self.items?[indexPath.row].data)
        self.selector?.clearConstraints()
        self.removeFromSuperview()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(config?.rowHeight ?? 44)
    }
}

extension UIView {
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
