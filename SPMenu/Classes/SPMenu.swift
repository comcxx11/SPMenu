import UIKit
import SnapKit

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public struct SPMenuConfig {
    public enum SPMenuType {
        case normal
        case image
        case fullImage
    }
    
    public var bgColor: UIColor = .white
    public var maxWidth: CGFloat = 250
    public var rowHeight = 44
    public var font: UIFont = UIFont.systemFont(ofSize: 14)
    public var type: SPMenuType = .normal
    
    public init(type: SPMenuType = .normal) {
        self.type = type
    }
}

public struct SPMenuData<T> {
    public init(title: String?, data: T) {
        self.title = title
        self.data = data
    }
    
    public init(title: String?, imageName: String?,  data: T) {
        self.title = title
        self.imageName = imageName
        self.data = data
    }
    
    public var title: String?
    public var imageName: String?
    public var data: T
}

class SPMenuCell: UITableViewCell {
    let fullImage = UIImageView()
    let type = SPMenuConfig.SPMenuType.normal
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(fullImage)
        
        fullImage.frame = CGRect(x: 0, y: 0, width: 250, height: 38)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if type == .image {
            self.imageView?.frame = CGRect(x: 2, y: 2, width: 42, height: 38)
        }
    }
}

open class SPMenu<T>: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dim = UIView(frame: CGRect.zero)
    open var selector: UITableView?
    open var bg = UIView()
    var offset: CGPoint?
    var items:[SPMenuData<T>]?
    
    open var row: Int = 0
    var showSelectedItem = true
    
    open var selectItem:((T?)->Void)?
    
    open var updateHeight:((CGFloat)->())?
    
    open var height:CGFloat = 0
    
    open var config: SPMenuConfig?
    
    public func count() -> Int {
        return items?.count ?? 0
    }
    
    public func getItem() -> T? {
        let i = items?[exist: row]?.data
        return i
    }
    
    public convenience init(target: UIView, config: SPMenuConfig? = nil) {
        let origin = target.frame.origin
        let x = origin.x
        let y = origin.y + target.frame.size.height
        
        self.init(frame: target.frame)
        self.offset = CGPoint(x: x, y: y)
        
        if let c = config {
            self.config = c
        } else {
            self.config = SPMenuConfig()
        }
        
        drawBackground()
        drawMenu()
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
        self.reset()
        
        if let cnt = items?.count {
            let rowHeight = config?.rowHeight ?? 44
            height = CGFloat(rowHeight * cnt)
            selector?.frame = CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: height)
            updateHeight?(height)
        }
    }
    
    public func reset(idx: Int = 0) {
        self.row = idx
        self.selector?.reloadData()
    }
    
    public func callFirst() {
         self.selectItem?(self.items?.first?.data)
    }
    
    public func selectItem(row: Int) {
        self.selectItem?(self.items?[exist: row]?.data)
    }
    
    private func drawMenu() {
        selector = UITableView(frame: CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 200, height: 200))
        if let m = selector {
            self.addSubview(m)
        }
        
        selector?.register(SPMenuCell.self, forCellReuseIdentifier: "SPMenuCell")
    
        selector?.backgroundColor = config?.bgColor
        selector?.delegate = self
        selector?.dataSource = self
        
        selector?.alwaysBounceVertical = false
        
        selector?.layer.cornerRadius = 8
    }
    
    @objc private func tapHandler() {
        removeConstraints()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    /// Core Graphics를 사용하는 이미지 리사이징
    /// 원본 : CGImage,  결과 : CGImage
    func resize(image: CGImage, scale: CGFloat, completionHandler: (CGImage?) -> Void)
    {
        let size = CGSize(width: CGFloat(image.width), height: CGFloat(image.height))
        let context = CGContext( // #1
            data: nil,
            width: Int(size.width * scale),
            height: Int(size.height * scale),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.interpolationQuality = .high // #2
        context.draw(image, in: CGRect(origin:.zero, size:size))
        let resultImage = context.makeImage()
        completionHandler(resultImage)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SPMenuCell", for: indexPath) as! SPMenuCell
        
        switch config?.type {
        case .normal:
            cell.fullImage.isHidden = true
        case .image:
            cell.fullImage.isHidden = true
            if let imgName = self.items?[indexPath.row].imageName {
                if let img = UIImage(named: imgName)?.cgImage {
                    resize(image: img, scale: 1, completionHandler: { resizedImage in
                        if let ok = resizedImage {
                            cell.imageView?.image = UIImage(cgImage: ok)
                        }
                        
                    })
                }
                
                
            }
        case .fullImage:
            cell.fullImage.isHidden = false
            if let imgName = self.items?[indexPath.row].imageName {
                cell.fullImage.image = UIImage(named: imgName)
                cell.fullImage.contentMode = .scaleAspectFit
            }
        default:
            break
        }
        
        switch config?.type {
        case .normal, .image:
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.font = config?.font
            cell.textLabel?.textColor = .black
            cell.textLabel?.text = self.items?[indexPath.row].title
        default:
            break
        }
        
        cell.backgroundColor = .clear
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        cell.selectionStyle = .gray
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selector?.deselectRow(at: indexPath, animated: true)
        row = indexPath.row
        selectItem?(self.items?[indexPath.row].data)
        removeConstraints()
    }
    
    private func removeConstraints() {
        selector?.clearConstraints()
        bg.clearConstraints()
        removeFromSuperview()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = config?.rowHeight ?? 44
        return CGFloat(rowHeight)
    }
    
    public func addBackground() {
        bg.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        bg.backgroundColor = .white
        bg.layer.cornerRadius = 8
        insertSubview(bg, at: 0)
        
        bg.layer.shadowOpacity = 0.3
        bg.layer.shadowOffset = CGSize(width: 0, height: 0)
        bg.layer.shadowRadius = 4
        bg.layer.masksToBounds = false
        
        // self.selector?.reloadRows(at: [IndexPath(row: row, section: 0), IndexPath(row: prevRow, section: 0)], with: .none)
    }
}

extension UIView {
    open func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}

struct Connector {
    var target: UIView
    var sender: UIView
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            let win = UIApplication.shared.windows.first { $0.isKeyWindow }
            if win == nil {
                return UIApplication.shared.windows.first
            } else {
                return win
            }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}


extension UIApplication {
    class func topViewController(base: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

open class MenuManager<T> {
    
    open var menu:SPMenu<T>?
    open var callFirst:Bool
    
    public func count() -> Int {
        return menu?.count() ?? 0
    }
    
    public func setRow(idx: Int) {
        menu?.row = idx
    }
    
    public init(callFirst: Bool = true, showSelectedItem: Bool = true, config: SPMenuConfig? = nil) {
        if menu == nil {
            let window = UIWindow.key ?? UIWindow()
            self.menu = SPMenu<T>(target: window, config: config)
            self.menu?.showSelectedItem = showSelectedItem
        }
        
        self.callFirst = callFirst
    }
    
    public func updateData(data: [SPMenuData<T>]) {
        self.menu?.reloadData(data: data)
        if callFirst {
            self.menu?.callFirst()
        }
    }
    
    public func show(sender: UIView) {
        guard let menu = self.menu else { return }
        menu.addBackground()
        
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        
        let connector = Connector(target: topVC.view, sender: sender)
        
        connector.target.addSubview(menu)
        
        let c = SPMenuFigure(con: connector, menu: menu)
        let size = c.size
        
        menu.selector?.snp.makeConstraints{
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            
            switch c.direction {
            case .down:
                $0.top.equalTo(connector.sender.snp.bottom)
            case .up:
                $0.bottom.equalTo(connector.sender.snp.top)
            }
            
            $0.leading.equalTo(connector.sender.snp.leading)
        }
        
        menu.bg.snp.makeConstraints{
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            
            switch c.direction {
            case .down:
                $0.top.equalTo(connector.sender.snp.bottom)
            case .up:
                $0.bottom.equalTo(connector.sender.snp.top)
            }
            
            $0.leading.equalTo(connector.sender.snp.leading)
        }
    }
}
