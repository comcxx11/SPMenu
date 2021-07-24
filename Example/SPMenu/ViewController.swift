//
//  ViewController.swift
//  SPMenu
//
//  Created by comcxx11 on 07/24/2021.
//  Copyright (c) 2021 comcxx11. All rights reserved.
//

import UIKit
import SPMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ok(_ sender: UIButton) {
        let origin = sender.frame.origin
        let x = origin.x
        let y = origin.y + sender.frame.size.height
        let a = SPMenu(frame: self.view.frame, offSet: CGPoint(x: x, y: y))
        self.view.addSubview(a)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

