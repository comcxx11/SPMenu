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

class ViewController: UIViewController {
    
    var menuManager: MenuManager<inboundChannels>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        var config = SPMenuConfig()
        config.bgColor = .white
        config.rowHeight = 50
        config.maxWidth = 200
        menuManager = MenuManager(config: config)
        
        // add event
        menuManager?.menu?.selectItem = {
            if let data = $0 {
                print(data)
            }
        }
        
        // add data
        menuManager?.updateData(data: MenuDataConverter.regularAmount(value: MenuDataConverter.getDummy()))
    }

    @IBAction func ok(_ sender: UIButton) {
        
        // show menu
        menuManager?.show(sender: sender)
    }
    
    @IBAction func menu2(_ sender: UIButton) {
        // show menu
        menuManager?.show(sender: sender)
    }
}


// CUSTOM DATA
struct inboundChannels: Codable {
    var sortNo: Int?
    var downloadUrl: String?
    var text: String?
    var type: Int?
    var url: String?
}

// DUMMY DATA
class MenuDataConverter {
    static func regularAmount(value: [inboundChannels]?) -> [SPMenuData<inboundChannels>] {
        var new: [SPMenuData<inboundChannels>] = []
        for i in value ?? [] {
            new.append(SPMenuData(title: i.downloadUrl, data: i))
        }
        
        return new
    }
    
    static func getDummy() -> [inboundChannels] {
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

