//
//  encuestaItem.swift
//  MobileSupervision
//
//  Created by lbriceno on 11/1/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class encuestaItem : UITableViewCell{
    @IBOutlet weak var stackview: UIView!
    @IBOutlet weak var firma: UIButton!
    @IBOutlet weak var preguntaAbiertaTxt: UITextField!
    @IBOutlet weak var siNoSwitch: UISwitch!
    @IBOutlet weak var comentarioTxt: UITextField!
    @IBOutlet weak var fotoMax: UILabel!
    
    @IBOutlet weak var fotoQuantity: UILabel!
    var delegate : EncuestaCellDelegate?;
    var preguntaitem: Encuesta!;
    
   
    
    @IBOutlet weak var pregunta: UILabel!
    class func instanceFromNib() -> encuestaItem {
        return UINib(nibName: "encuestaItem", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! encuestaItem
    }
    
    @IBAction func takephotoAction(_ sender: Any) {
        self.delegate?.takePhoto(sender: self)
    
    }
    
    @IBAction func takeSignature(_ sender: Any) {
        self.delegate?.takeSignature(sender: self)

    }
    
    @IBOutlet weak var takePhoto: UIButton!
}
protocol EncuestaCellDelegate: class {
    func takePhoto(sender: encuestaItem)
    func takeSignature(sender: encuestaItem)

}
