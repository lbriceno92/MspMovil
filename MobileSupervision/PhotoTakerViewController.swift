//
//  PhotoTakerViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 11/11/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class PhotoTakerViewController : BaseViewController {
    override func viewDidLoad() {
        let button = UIBarButtonItem(title: "Tomar foto", style: .plain, target: self, action:Selector("openCamera"))
        self.navigationItem.rightBarButtonItem = button;
    }
    
    func openCamera(){
        
    }
}
