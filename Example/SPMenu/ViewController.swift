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

public struct inboundChannels: Codable {
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

class MenuDataConverter {
    static func regularAmount(value: [inboundChannels]?) -> [SPMenuData<inboundChannels>] {
        var new: [SPMenuData<inboundChannels>] = []
        for i in value ?? [] {
            new.append(SPMenuData(title: i.downloadUrl, data: i))
        }
        
        return new
    }
}


class ViewController: UIViewController {
    
    
    var menuManager: MenuManager<inboundChannels> = MenuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuManager.updateData(data: MenuDataConverter.regularAmount(value: getDummy()))
        menuManager.menu?.selectItem = {
            if let data = $0 {
                print(data)
            }
        }
    }

    @IBAction func ok(_ sender: UIButton) {
        menuManager.show(sender: sender)
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
