import UIKit

open class SPMenu: UIView {
    var dim = UIView(frame: CGRect.zero)
    var menu: UITableView?
    var offset: CGPoint?
    
    public convenience init(frame: CGRect, offSet: CGPoint) {
        self.init(frame: frame)
        self.offset = offSet
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        dim.frame = self.frame
        dim.backgroundColor = .blue
        dim.alpha = 0.2
        
        let ges = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        dim.addGestureRecognizer(ges)
        
        self.addSubview(dim)
        
        menu = UITableView(frame: CGRect(x: offset?.x ?? 0, y: offset?.y ?? 0, width: 100, height: 100))
        if let m = menu {
            self.addSubview(m)
        }
    }
    
    @objc private func tapHandler() {
        self.removeFromSuperview()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
