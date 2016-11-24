//
//  GastosViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 11/5/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class GastosViewControlelr : BaseViewController, UITextViewDelegate,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return segmentedController.selectedSegmentIndex == 0 ? itemsGastos.count : itemsIngreso.count;
    }
    
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
    @IBOutlet weak var gastoIdTextView: UITextField!
    @IBOutlet weak var addGastoButton: UIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var importeTxt: UITextField!
    @IBOutlet weak var comentario: UITextView!
    @IBOutlet weak var conceptoTxt: UITextField!
    
    var folioAdded = false;
    var picker : UIPickerView?;
    var nomGasto : String?;
    var idGasto: String?;
    var itemsGastos = Array<Item>();
    var itemsIngreso = Array<Item>();
    var selectedItem : Item?;
    
    override func viewDidLoad() {
        let button = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action:Selector("guardar"))
        self.navigationItem.rightBarButtonItem = button;
        self.tabBarController?.navigationItem.rightBarButtonItem = button
        var tapgesture = UITapGestureRecognizer(target: self, action: Selector("showPicker"))
        
        itemsGastos.append(Item(nombre: "Seleccione", id: 0))
        itemsIngreso.append(Item(nombre: "Seleccione", id: 0))
        itemsGastos.append(Item(nombre: "estacionamiento", id: 1))
        
        picker = UIPickerView();
        picker?.dataSource = self;
        picker?.delegate = self;
        picker?.backgroundColor = UIColor.gray
        picker?.frame = CGRect(x: 0, y: self.view.frame.size.height - 200, width: self.view.frame.size.width, height: 200)
        picker?.showsSelectionIndicator = true;
        conceptoTxt.delegate = self
        
        var btn = UIButton(type: UIButtonType.roundedRect);
        btn.setTitle("Seleccionar", for: UIControlState.normal)
        
        var done = UIButton(type: UIButtonType.roundedRect);
        done.setTitle("Done", for: UIControlState.normal)
        done.target(forAction: Selector("hide"), withSender: done);
        
        var viewGesture = UITapGestureRecognizer(target: self, action: Selector("hide"))
        self.view.addGestureRecognizer(tapgesture);
        
        var toolbar = UIToolbar();
        
        toolbar.barStyle = UIBarStyle.default;
        toolbar.sizeToFit()
        
        //to make the done button aligned to the right
        var flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: Selector("hide"))
        toolbar.setItems([flexibleSpaceLeft,doneButton], animated: true)
        self.importeTxt.inputAccessoryView = toolbar
        
        self.comentario.layer.borderColor = UIColor.lightGray.cgColor;
        self.comentario.layer.cornerRadius = 10
        self.comentario.layer.masksToBounds = true;
        self.comentario.layer.borderWidth = 1
    }
    
    @IBAction func addFolio(_ sender: Any) {
        
        self.folioAdded = !self.folioAdded;
        self.addGastoButton.setTitle(self.folioAdded ? "x" : "+", for: UIControlState.normal) ;
        
        if folioAdded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddhhmmss"
            var stringformat = dateFormatter.string(from: Date())
            var string = String(format: "%d%@", arguments:[User.sharedInstance.id!,stringformat])
            self.gastoIdTextView.text = string
        }else{
            self.gastoIdTextView.text = "";
            self.importeTxt.text = "";
            self.conceptoTxt.text = "Seleccione";
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == self.conceptoTxt) {
            
            self.conceptoTxt.inputView = self.picker;
            self.picker?.isHidden = false;
            
            var toolbar = UIToolbar();
            
            toolbar.barStyle = UIBarStyle.blackTranslucent;
            toolbar.sizeToFit()
            
            //to make the done button aligned to the right
            var flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
            var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: Selector("doneClicked"))
            toolbar.setItems([flexibleSpaceLeft,doneButton], animated: true)
            
            self.conceptoTxt.inputAccessoryView = toolbar;
        }
    }
    func hide(){
        picker?.isHidden = false;
        self.view.endEditing(true)
    }
    
    func doneClicked(){
        //self.picker?.isHidden = true;
        self.conceptoTxt.text = self.selectedItem == nil ? self.itemsGastos[0].nombre : self.selectedItem?.nombre
        
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return segmentedController.selectedSegmentIndex == 0 ? itemsGastos[row].nombre! as String : itemsIngreso[row].nombre! as String;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedItem = segmentedController.selectedSegmentIndex == 0 ? itemsGastos[row] : itemsIngreso[row]
        
    }
    
    
    
    func showPicker(){
        self.picker?.isHidden = false;
    }
    
    
    func guardar() -> Void {
        self.view.endEditing(true)
        print("guardando")
        var q =  "INSERT INTO tab_gastoseingresos ( id_usu ,cve_usu ,folio_gastoseingresos ,id_catgastos ,nom_gastoseingresos ,importe_gastoseingresos ,comentario_gastoseingresos ,fecha_gastoseingresos ,id_sinc ,fecha_sinc) VALUES (\(User.sharedInstance.id!) , '\(User.sharedInstance.user_id!)', '\(gastoIdTextView.text!)','\(self.selectedItem!.id!)', '\(self.selectedItem!.nombre!)', '\(importeTxt.text!)', '', '' , 1, DATETIME('now'))";
        do{
            try SqlLiteManager.db?.run(q);
        }catch{
            print("error")
        }
        
    }
    
}
