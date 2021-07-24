import UIKit


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
    open var menu: UITableView?
    var offset: CGPoint?
    var items:[SPMenuData<T>]?
    
    open var selectItem:((T?)->Void)?
    
    public convenience init(frame: CGRect, offSet: CGPoint? = nil) {
        self.init(frame: frame)
        self.offset = offSet
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
        self.menu?.reloadData()
        
        if let cnt = items?.count {
            menu?.frame = CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: CGFloat(44 * cnt))
        }
        
    }
    
    private func drawMenu() {
        menu = UITableView(frame: CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: 200))
        if let m = menu {
            self.addSubview(m)
        }
        
        menu?.delegate = self
        menu?.dataSource = self
        
        menu?.alwaysBounceVertical = false
    }
    
    private func setup() {
        drawBackground()
        drawMenu()
    }
    
    @objc private func tapHandler() {
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
        cell.contentView.backgroundColor = .gray
        cell.textLabel?.text = self.items?[indexPath.row].title
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menu?.deselectRow(at: indexPath, animated: true)
        self.selectItem?(self.items?[indexPath.row].data)
        self.removeFromSuperview()
    }
    
}

