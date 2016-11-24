//
//  Client.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/23/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation

class Client {
    var order:Int64!,key:String!,name:String!,contact:String!,dir:String!,phone:String!,cell:String!;
    
    init(withName name : String, order : Int64, contact : String, dir : String, phone:String,cell:String,key: String){
        self.order =  order;
        self.name = name;
        self.contact = contact;
        self.dir = dir;
        self.phone = phone;
        self.cell = cell;
        self.key = key;
    }
    
    
    
}
