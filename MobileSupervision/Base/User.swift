//
//  User.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/26/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation

class User {
    
    //MARK: Shared Instance
    var id,user_id,userp : String?;
    static let sharedInstance : User = {
        let instance = User()
        return instance
    }()
    
    func setData(id:String,user_id :String, user_p : String) {
        self.id = id;
        self.user_id = user_id;
        self.userp = user_p
    }
}
