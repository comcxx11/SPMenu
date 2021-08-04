//
//  SPMenuConfig.swift
//  SPMenu
//
//  Created by 홍서진 on 2021/08/04.
//

import UIKit

open class SPMenuFigure<T> {
    // global point target center
    var gptc: CGPoint
    var winHeight: CGFloat
    var halfWinHeight: CGFloat
    var maxWidth: CGFloat
    var originHeight: CGFloat
    var targetWidth: CGFloat
    
    // up weight value : 100 ~
    // down weight value : -100 ~
    let centerWeight:CGFloat = 100
    let defaultPadding:CGFloat = 80
    
    var rowHeight:Int
    
    public init(target: UIView, menu: SPMenu<T>) {
        gptc = target.superview?.convert(target.center, to: nil) ?? CGPoint(x: 0, y: 0)
        winHeight = UIScreen.main.bounds.size.height
        halfWinHeight = winHeight / 2
        maxWidth = CGFloat(menu.config?.maxWidth ?? 0)
        originHeight = menu.height
        targetWidth = target.frame.width
        rowHeight = menu.config?.rowHeight ?? 0
    }
    
    public enum Direction {
        case down
        case up
    }
    
    public var direction:Direction {
        if  gptc.y < halfWinHeight + centerWeight {
            return .down
        } else {
            return .up
        }
    }
    
    var downHeight: CGFloat {
        return winHeight - gptc.y
    }
    
    var upHeight: CGFloat {
        return winHeight - (winHeight - gptc.y)
    }
    
    var w:CGFloat {
        return targetWidth > maxWidth ? maxWidth : targetWidth
    }
    
    public var size: CGSize {
        return CGSize(width: w, height: h)
    }
    
    var marginHeight: CGFloat {
        switch direction {
        case .down:
            return downHeight
        case .up:
            return upHeight
        }
    }
    
    var h:CGFloat {
        let hValue = defaultHeight
        if hValue == 0 {
            return 0
        }
        let cnt:Int = Int(hValue / CGFloat(rowHeight))
        return CGFloat(cnt * rowHeight)
    }
    
    var defaultHeight: CGFloat {
        if originHeight > marginHeight {
            return marginHeight - defaultPadding
        } else {
            return originHeight - defaultPadding
        }
    }
    
}
