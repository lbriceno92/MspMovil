//
//  ClientInfoViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/24/16.
//  Copyright © 2016 MBOX. All rights reserved.
//
import UIKit
class ClientInfoViewController : BaseViewController{
    
    var client : Client?;
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientKey: UILabel!
    @IBOutlet weak var clientDir: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientCellphone: UILabel!
    
    override func viewDidLoad() {
        self.clientName.text = self.client?.name;
        self.clientKey.text = "\(self.client!.key!)";
        self.clientDir.text = self.client?.dir;
        self.clientPhone.text = self.client?.phone;
        self.clientCellphone.text = self.client?.cell;
        
    }
    
    func prepareForClient(client : Client){
        self.client = client;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "encuestashow"{
            let vc = segue.destination as! SupervisionViewController;
            vc.prepareForClient(client: self.client!)
        }else if  segue.identifier == "novisitashow"{
            let vc = segue.destination as! NoVisitaViewController;
            vc.prepareFord(empvId: (self.client?.key)!)
        }
    }
    
    
    @IBAction func noVisitaClicked(_ sender: Any) {
    }

    
    @IBAction func supervisionClicked(_ sender: Any) {
    }
    
}
