//
//  ViewController.swift
//  SPMenu
//
//  Created by comcxx11 on 07/24/2021.
//  Copyright (c) 2021 comcxx11. All rights reserved.
//

import UIKit
import SPMenu
import SnapKit

struct cashList: Codable {
    var sortNo: String?
    var cashName: String?
    var amounts: String?
    var maxVal: String?
    var minVal: String?
    var hint: String?
}

struct inboundChannels: Codable {
    var sortNo: Int?
    var downloadUrl: String?
    var text: String?
    var type: Int?
    var url: String?
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

class ViewController: UIViewController {

    var data = ["a", "b"]
    
    var a:SPMenu<inboundChannels>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ok(_ sender: UIButton) {
        let origin = sender.frame.origin
        let x = origin.x
        let y = origin.y + sender.frame.size.height
        
        let d1 = [inboundChannels(sortNo: 1, downloadUrl: "10,000", text: "10,000", type: 1, url: ""),
                  inboundChannels(sortNo: 2, downloadUrl: "20,000", text: "20,000", type: 1, url: ""),
                  inboundChannels(sortNo: 3, downloadUrl: "20,000", text: "30,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                  inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
        ]
        
        var d: [SPMenuData<inboundChannels>] = []
        for i in d1 {
            d.append(SPMenuData(title: i.text, data: i))
        }
        
        if a == nil {
            a = SPMenu<inboundChannels>(frame: self.view.frame, offSet: CGPoint(x: x, y: y))
        }
        
        a?.reloadData(data: d)
        a?.selectItem = { item in
            print(item?.downloadUrl ?? "")
        }
        
        if let menu = a {
            self.view.addSubview(menu)
            let globalPoint = sender.superview?.convert(sender.frame.origin, to: nil)
            let p = UIScreen.main.bounds.size.height - CGFloat(globalPoint?.y ?? 0) - sender.frame.size.height - 10
            if  p > menu.height {
                menu.menu?.snp.makeConstraints{
                    $0.leading.equalTo(sender.snp_leading)
                    $0.top.equalTo(sender.snp_bottom)
                    $0.width.equalTo(200)
                    $0.height.equalTo(menu.height)
                }
            } else {
                menu.menu?.snp.makeConstraints{
                    $0.leading.equalTo(sender.snp_leading)
                    $0.bottom.equalTo(sender.snp_top)
                    $0.width.equalTo(200)
                    $0.height.equalTo(menu.height)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

