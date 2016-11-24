//
//  MenuViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/22/16.
//  Copyright © 2016 MBOX. All rights reserved.
//
import Foundation

class  MenuViewController :BaseViewController{
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func miRutaClicked(_ sender: Any) {
    }
    
    @IBAction func consultaClientesClicked(_ sender: Any) {
    }
    @IBAction func gastosClicked(_ sender: Any) {
    }
    @IBAction func cloudSyncClicked(_ sender: Any) {
    }
}
