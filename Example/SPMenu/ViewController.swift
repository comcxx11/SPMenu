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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ok(_ sender: UIButton) {
        let dummyData = getDummy()
        
        let data = MenuDataConverter.inboundChannels(value: dummyData)
        let connector = MenuManager<inboundChannels>.Connector(target: self.view, sender: sender)
        let menuManager = MenuManager<inboundChannels>(connector: connector, data: data)
        
        menuManager.menu.selectItem = {
            print($0?.downloadUrl ?? "")
        }
    }
    
    private func getDummy() -> [inboundChannels] {
        return [inboundChannels(sortNo: 1, downloadUrl: "10,000", text: "10,000", type: 1, url: ""),
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
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "40,000", type: 1, url: ""),
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
    }
}

class MenuDataConverter {
    static func inboundChannels(value: [inboundChannels]) -> [SPMenuData<inboundChannels>] {
        var new: [SPMenuData<inboundChannels>] = []
        for i in value {
            new.append(SPMenuData(title: i.text, data: i))
        }
        
        return new
    }
}


class MenuManager<T> {
    
    struct Connector {
        var target: UIView
        var sender: UIView
    }
    
    var menu:SPMenu<T>
    
    init(connector:Connector, data:[SPMenuData<T>]) {
        self.menu = SPMenu<T>(target: connector.target)
        self.menu.reloadData(data: data)
        updateDisplay(connector: connector)
    }
    
    private func updateDisplay(connector: Connector) {
        
        connector.target.addSubview(menu)
        menu.selector?.snp.makeConstraints{
            let c = SPMenuFigure(target: connector.sender, menu: menu)
            let size = c.size
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            
            switch c.direction {
            case .down:
                $0.top.equalTo(connector.sender.snp_bottom)
            case .up:
                $0.bottom.equalTo(connector.sender.snp_top)
            }
            
            $0.leading.equalTo(connector.sender.snp_leading)
        }
    }
}
