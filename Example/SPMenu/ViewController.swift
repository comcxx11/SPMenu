//
//  ViewController.swift
//  SPMenu
//
//  Created by comcxx11 on 07/24/2021.
//  Copyright (c) 2021 comcxx11. All rights reserved.
//

import UIKit
import SPMenu

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



class ViewController: UIViewController {

    var data = ["a", "b"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ok(_ sender: UIButton) {
        let origin = sender.frame.origin
        let x = origin.x
        let y = origin.y + sender.frame.size.height
        
        let d1 = [inboundChannels(sortNo: 1, downloadUrl: "10,000", text: "bb", type: 1, url: ""),
                  inboundChannels(sortNo: 2, downloadUrl: "20,000", text: "yy", type: 1, url: "")]
        
        var d: [SPMenuData<inboundChannels>] = []
        for i in d1 {
            d.append(SPMenuData(title: i.text, data: i))
        }
        
        let a = SPMenu<inboundChannels>(frame: self.view.frame, offSet: CGPoint(x: x, y: y))
        a.reloadData(data: d)
        a.selectItem = { item in
            print(item?.downloadUrl ?? "")
        }
        
        self.view.addSubview(a)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

