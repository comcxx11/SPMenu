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
    var menuManagerCustom: MenuManager<inboundChannels>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultMenu()
        
        setupCustomMenu()
    }
    
    private func setupDefaultMenu() {
        // MenuManager
        menuManager = MenuManager()
        
        // add event
        menuManager?.menu?.selectItem = {
            if let data = $0 {
                print(data)
            }
        }
        
        // add data
        menuManager?.updateData(data: MenuDataConverter.regularAmount(value: MenuDataConverter.getDummy()))
    }
    
    private func setupCustomMenu() {
        var config = SPMenuConfig()
        config.bgColor = .green
        config.rowHeight = 30
        config.maxWidth = 200
        
        // MenuManager
        menuManagerCustom = MenuManager(callFirst: false, config: config)
        
        // add event
        menuManagerCustom?.menu?.selectItem = {
            if let data = $0 {
                print(data)
            }
        }
        
        // add data
        menuManagerCustom?.updateData(data: MenuDataConverter.regularAmount(value: MenuDataConverter.getDummy()))
    }

    @IBAction func menu1(_ sender: UIButton) {
        
        // show menu
        menuManager?.show(sender: sender)
    }
    
    @IBAction func menu2(_ sender: UIButton) {
        // show menu
        menuManager?.show(sender: sender)
    }
    
    @IBAction func menu3(_ sender: UIButton) {
        menuManagerCustom?.show(sender: sender)
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
            new.append(SPMenuData(title: i.text, data: i))
        }
        
        return new
    }
    
    static func getDummy() -> [inboundChannels] {
        return [inboundChannels(sortNo: 1, downloadUrl: "10,000", text: "10,000", type: 1, url: ""),
                inboundChannels(sortNo: 2, downloadUrl: "20,000", text: "20,000", type: 1, url: ""),
                inboundChannels(sortNo: 3, downloadUrl: "30,000", text: "30,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "40,000", text: "40,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "50,000", text: "50,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "60,000", text: "60,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "70,000", text: "70,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "80,000", text: "80,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "90,000", text: "90,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "11,000", text: "11,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "12,000", text: "12,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "13,000", text: "13,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "14,000", text: "14,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "15,000", text: "15,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "16,000", text: "16,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "17,000", text: "17,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "18,000", text: "18,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "19,000", text: "19,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "20,000", text: "20,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "21,000", text: "21,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "22,000", text: "22,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "23,000", text: "23,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "24,000", text: "24,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "25,000", text: "25,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "26,000", text: "26,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "27,000", text: "27,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "28,000", text: "28,000", type: 1, url: ""),
                inboundChannels(sortNo: 4, downloadUrl: "29,000", text: "29,000", type: 1, url: ""),
      ]
    }
}

