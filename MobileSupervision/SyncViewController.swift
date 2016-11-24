//
//  ViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/5/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import UIKit
import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SyncViewController: BaseViewController {
    
    @IBOutlet weak var porcentageTextView: UILabel!
    @IBOutlet weak var textView: UITextView!
    var soapClient : SyedAbsarClient?;
    var ipAddress :String?;
    var appName :String?;
    var password :String?;
    var manager:SyncroManager?;
    
    func initWith(ipAddress:String, appName:String, password:String){
        self.ipAddress = ipAddress;
        self.appName = appName;
        self.password = password;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        soapClient = SyedAbsarClient(withIPAddress: self.ipAddress!);
        manager =  SyncroManager(withIPAddress:self.ipAddress!, appName: self.appName!, password: self.password!);
        manager?.getSessionID({ (response, hasError,finished) in
            
            if hasError! == true{
                self.appendInTextView(withString: response!)
                self.showErrorAlert(withMessage: response!);
            }else{
                self.appendInTextView(withString: response!)
            }
            if finished!{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
                
                do{
                    var result = try SqlLiteManager.db?.prepare("SELECT id_usu, cve_usu from tab_usuarios");
                    
                    for r in result!{
                        User.sharedInstance.setData(id: "0", user_id: "\(r[0]!)", user_p: "\(r[1]!)")
                        print(r)
                    }
                }catch{
                    
                }
                self.delay(delay: 3, closure: {
                    self.present(controller, animated: true, completion: nil)
                })
            }
            
        });
    }
    
    func delay(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        
    }
    
    
    func appendInTextView(withString string:String){
        DispatchQueue.main.async {
            var porc = 0.0;
            
            if self.manager?.downloadTables.count > 0 {
                porc = Double((self.manager?.totalDownloadedTables)!) / Double((self.manager?.downloadTables.count)!)
                porc = porc * 100 ;
            }
            
            self.porcentageTextView.text = String(format:"%0.f de 100%",porc);
            
            self.textView.text = String(format:"%@\n%@",self.textView.text,string);
            self.textView.scrollRangeToVisible(NSMakeRange(self.textView.text.characters.count - 1, 1));
        }
    }
    
    func showErrorAlert(withMessage stringMessage:String){
        
        
        let errorAlert = UIAlertController(title: "Error", message: stringMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil);
        }))
        
        present(errorAlert, animated: true, completion: nil)
        
    }
    
    
    
}

