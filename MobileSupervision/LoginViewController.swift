//
//  LoginViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/12/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : BaseViewController,UITextFieldDelegate{
    
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var passwordLBL: UILabel!
    
    var password: String = "";
    
    override func viewDidLoad() {
        
        for button in buttons {
            button.layer.borderWidth = 1;
            button.layer.borderColor = UIColor.clear.cgColor;
            button.layer.masksToBounds = true;
            button.layer.cornerRadius = button.frame.width/2;
        }
        
     
    }
    
    @IBAction func cancelAction(_ sender: AnyObject) {
        password  = "";
        passwordLBL.text = password;
        
        
    }
    
    @IBAction func configAction(_ sender: Any) {
        showServerConfigAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "server_ip") == nil ||  UserDefaults.standard.string(forKey: "app_name") == nil {
            
        
            
            self.showServerConfigAlert();
        }
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor;
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderWidth = 2
        okButton.layer.borderColor = UIColor.lightGray.cgColor;
        okButton.layer.cornerRadius = 5
        okButton.layer.borderWidth = 2
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if password.characters.count <= 3 {
            password = String(format:"%@%@",password,"\(sender.titleLabel!.text!)");
            passwordLBL.text = String(format:"%@%@",passwordLBL.text!,"*");
            print("\(sender.titleLabel!.text!)")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "startSync") {
            // pass data to next view
            let viewController = segue.destination as? SyncViewController;
            viewController!.initWith(ipAddress:UserDefaults.standard.string(forKey: "server_ip")!, appName: UserDefaults.standard.string(forKey: "app_name")!, password: password);
        }
    }
    
    func showServerConfigAlert(){
        
        if UserDefaults.standard.string(forKey: "server_ip") == nil {
            UserDefaults.standard.set("64.151.103.133:80", forKey: "server_ip");
        }
        
        let alertController = UIAlertController(title: "\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let margin:CGFloat = 8.0
        
        let rect = CGRect(origin: CGPoint( x: margin, y: margin), size: CGSize(width: 250, height: 100));
        
        let customView = UIView(frame: rect)
        var height = 0;
        
        customView.center = CGPoint(x: ((rect.midX*2)/2), y: rect.midY)
        
        
        let textServer = UITextField(frame: CGRect(origin: CGPoint( x: 0, y: height), size: CGSize(width: customView.bounds.size.width , height: 50.0)));
        textServer.placeholder = "Server Address"
        textServer.text = UserDefaults.standard.string(forKey: "server_ip")!;
        textServer.borderStyle = UITextBorderStyle.roundedRect
        textServer.isEnabled = true;
        textServer.returnKeyType = UIReturnKeyType.done;
        height += Int(textServer.bounds.height)
        
        
        let textName = UITextField(frame: CGRect(origin: CGPoint( x: 0, y: (height + Int(margin))), size: CGSize(width: customView.bounds.size.width , height: 50.0)));
        textName.isEnabled = true;
        textName.borderStyle = UITextBorderStyle.roundedRect
        textName.placeholder = "Application Name"
        textName.returnKeyType = UIReturnKeyType.done;
        textName.text =  UserDefaults.standard.string(forKey: "app_name");
        height += Int(textServer.bounds.height)
        
        
        textName.delegate = self;
        textServer.delegate = self;
        
        customView.addSubview(textName);
        customView.addSubview(textServer);
        
        alertController.view.addSubview(customView)
        
        //        let somethingAction = UIAlertAction(title: "Something", style: UIAlertActionStyle.Default, handler: {
        //            (alert: UIAlertAction!) in println("something")})
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            UserDefaults.standard.set(textServer.text, forKey: "server_ip");
            UserDefaults.standard.set(textName.text, forKey: "app_name");
            
        }))
        
        
        present(alertController, animated: true, completion:{})

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
  
}
