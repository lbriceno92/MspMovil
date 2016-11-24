//
//  BaseViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/12/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import UIKit
import Foundation

class BaseViewController : UIViewController{
    
    var sqlManager: SqlLiteManager = SqlLiteManager();
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        super.viewWillAppear(animated)
      
    }
    
      
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
