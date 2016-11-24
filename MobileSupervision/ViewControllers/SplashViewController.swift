//
//  SplashViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/11/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    @IBOutlet weak var initBtn: UIButton!
    
    override func viewDidLoad() {
        initBtn.layer.borderColor = UIColor.lightGray.cgColor;
        initBtn.layer.cornerRadius = 5
        initBtn.layer.borderWidth = 2
    }
}
