//
//  EncuestaViewcontroller.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/30/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class EncuestaViewcontroller : BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate,UITextFieldDelegate, EncuestaCellDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UINavigationControllerDelegate,EPSignatureDelegate{
    

    
    @IBOutlet var viewsInStack: [UIView]!
    var encuestas = Array<Encuesta>();
    var encuesta: Encuesta!;
    @IBOutlet weak var stackview: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var multipleImagePicker: RPMultipleImagePickerViewController?;
    var  photoCell : encuestaItem!;
    var  firmaCell : encuestaItem!;

    var noped_usu_encuesta : String!;
    var empvId : String!;
    var count = 0;
    var boolfirmo = false;
    
    override func viewDidLoad() {
        print(encuesta?.idPregunta)
        
        var stm = "SELECT tab_pregunta.id_pregunta, pregunta, id_preguntatipo, cantidad_foto, cant_minfoto, IFNULL(id_respuesta, 0) AS id_respuesta, IFNULL(respuesta, '') AS respuesta, IFNULL(flag_comentario, 0) AS flag_comentario FROM tab_pregunta  LEFT JOIN tab_preguntarespuesta ON tab_pregunta.id_pregunta = tab_preguntarespuesta.id_pregunta INNER JOIN tab_preguntaencuesta ON tab_pregunta.id_pregunta = tab_preguntaencuesta.id_pregunta WHERE id_encuesta = "+encuesta.idPregunta! ;
        do{
            var result = try SqlLiteManager.db?.run(stm);
            var lastid = ""
            var currentEncuesta: Encuesta?;
            for row in result!{
                print(row)
                
                if  "\(row[0]!)" != lastid {
                    let encuesta = Encuesta(idPregunta:  "\(row[0]!)", nombre:  "\(row[1]!)", idPreguntaTipo:  "\(row[2]!)", maxFotos:  "\(row[3]!)", numFotos:  "0", cantMinFotos:  "\(row[4]!)", abierta:  ""   , pos:  0);
                    currentEncuesta = encuesta;
                    encuestas.append(encuesta)
                    lastid = encuesta.idPregunta!
                }
                var respuesta = Respuesta(withId: Int(truncatingBitPattern: row[5] as! Int64), respuesta: "\(row[6]!)", flagComentario: Int(truncatingBitPattern: row[7] as! Int64), comentario: "", idVisita: UIView().hash, selected: false);
                currentEncuesta?.respuestas.append(respuesta)
            }
            
        }catch{
            
        }
        
        let button = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action:Selector("guardar"))
        self.navigationItem.rightBarButtonItem = button;
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        let sw: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(sw)
        
        view.addGestureRecognizer(tap)
        
        self.multipleImagePicker = RPMultipleImagePickerViewController()
        self.multipleImagePicker?.sourceType = UIImagePickerControllerSourceType.camera
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        var stringformat = dateFormatter.string(from: Date())
        self.noped_usu_encuesta = "\(User.sharedInstance.user_id!)\(empvId!)\(stringformat)"
    }
    
    func guardar() -> Void {
        print("guardando")
        
        for (index,encuesta) in encuestas.enumerated(){
            print("\(encuesta)")
            self.tableView.scrollToRow(at:  IndexPath(row: index, section: 0), at: UITableViewScrollPosition.top, animated: false)
            let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! encuestaItem
            
            if encuestas[index].idPreguntaTipo == "1" {
                encuestas[index].abierta = cell.preguntaAbiertaTxt.text
            }
            
            var preguntaType = Int(encuesta.idPreguntaTipo!)!;
            print(encuestas[index].respuestas)
            
            if preguntaType == 1{
                if cell.preguntaAbiertaTxt.text == nil {
                    return;
                }
                encuestas[index].respuestas[0].respuesta = cell.preguntaAbiertaTxt.text
                
            }else if preguntaType == 2{ // cerrada unica
                print((encuesta.segmentedController?.selectedSegmentIndex)!)
                if encuesta.segmentedController?.selectedSegmentIndex == nil {
                    return;
                }
                encuestas[index].respuestas[(encuesta.segmentedController?.selectedSegmentIndex)!].selected = true
                
            }else if preguntaType == 3{
                
                for (i,checkbox)in encuesta.checkboxes.enumerated(){
                    if checkbox.checkState == M13Checkbox.CheckState.checked {
                        encuestas[index].respuestas[i].selected = true
                    }
                }
                
            }else if preguntaType == 4{
                
                if self.photoCell.preguntaitem.numFotos != nil{
                        //
                    if Int(self.photoCell.preguntaitem.numFotos!)! == 0{
                        return;
                    }
                }
                
            }else if preguntaType == 5{
                if !boolfirmo {
                    return;
                }
            }else if preguntaType == 6{
                encuestas[index].posSiNo  = cell.siNoSwitch.isOn ? 1 : 2;
            }else{
                // (cell as! encuestaItem).contentView.isHidden = true;
            }
            print(encuesta)

        }
        
        for encuesta in encuestas {
            var preguntaType = Int(encuesta.idPreguntaTipo!)!;
            
            if preguntaType == 1{
                insertRespuesta(idPregunta: Int(encuesta.idPregunta!)!, respuestaSiNo: 0, idRespuesta: 0, idFoto: 0, resp_comentario: encuesta.abierta!)
            }else if preguntaType == 2 || preguntaType == 3{ // cerrada unica
                for respuesta in encuesta.respuestas{
                    if respuesta.selected! == true{
                        insertRespuesta(idPregunta: Int(encuesta.idPregunta!)!, respuestaSiNo: 0, idRespuesta: respuesta.idRespuesta!, idFoto: 0, resp_comentario: respuesta.comentario!)
                    }
                }
            
            }else if preguntaType == 4 || preguntaType == 5{
                var query = "SELECT _id, nom_foto FROM tab_fotocapturada WHERE noped_usu_encuesta = '\(self.noped_usu_encuesta!)' AND ID_PREGUNTA = \(encuesta.idPregunta)";
                do{
                    var result = try SqlLiteManager.db?.run(query);
                    for row in result! {
                        insertRespuesta(idPregunta: Int(encuesta.idPregunta!)!, respuestaSiNo: 0, idRespuesta: 0, idFoto:Int("\(row[0]!)")!, resp_comentario: row[1] as! String)
                    }
                }catch{
                    
                }
            }else if preguntaType == 6{
                insertRespuesta(idPregunta: Int(encuesta.idPregunta!)!, respuestaSiNo: encuesta.posSiNo!, idRespuesta: 0, idFoto: 0, resp_comentario: "")
            }
        }
       
        self.navigationController?.popViewController(animated: true)

    }
    
    func insertRespuesta(idPregunta: Int, respuestaSiNo: Int, idRespuesta: Int, idFoto: Int, resp_comentario: String){
        //store in sqllite
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        
        do{
            try SqlLiteManager.db?.run("INSERT INTO tab_encuestaRespuestas(id_vis, id_usu, id_empv,id_encuesta, noped_usu, noped_usu_encuesta, fecha_captura, id_pregunta, respuesta_si_no, id_respuesta, id_foto, resp_comentario, id_sinc, fecha_sinc) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [Date().hashValue,User.sharedInstance.user_id!,empvId!,encuesta.idPregunta!,noped_usu_encuesta!,noped_usu_encuesta!,dateFormatter.string(from: Date()),idPregunta,respuestaSiNo,idRespuesta,idFoto,resp_comentario,1,dateFormatter.string(from: Date())]);
            
          
        }catch{
            
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.delegate = self
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.encuestas.count;
    }
    
    func prepareFor(encuesta :Encuesta,empvId: String){
        self.empvId = empvId;
        self.encuesta = encuesta;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var encuesta = self.encuestas[indexPath.row];
        
        var preguntaType = Int(encuesta.idPreguntaTipo!)!;
        
        if preguntaType == 3{ // cerrada unica
            // (cell as! encuestaItem).stackview.viewWithTag(1)?.isHidden = false
            var height :CGFloat = 100;
            let controller = SSRadioButtonsController();
            for respuesta in encuesta.respuestas{
                
                height += 30;
            }
            return height
            
            
        }
        
        return 100;
        
        
    }
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var encuesta = self.encuestas[indexPath.row];
        
        var preguntaType = Int(encuesta.idPreguntaTipo!)!;
        print((cell as! encuestaItem).stackview.subviews)
        if preguntaType == 1{
            (cell as! encuestaItem).stackview.viewWithTag(2)?.isHidden = false
            (cell as! encuestaItem).preguntaAbiertaTxt.delegate = self
            
        }else if preguntaType == 2{ // cerrada unica
            // (cell as! encuestaItem).stackview.viewWithTag(1)?.isHidden = false
            var height :CGFloat = 0;
            let controller = SSRadioButtonsController();
            var segmentedController = UISegmentedControl(items: [])
            var count:Int = 0;
            var arr = Array<String>();
            for respuesta in encuesta.respuestas{
                arr.append(respuesta.respuesta!)
            }
            segmentedController = UISegmentedControl(items: arr)
            (cell as! encuestaItem).stackview.addSubview(segmentedController);
            encuesta.segmentedController = segmentedController;
            
            
            cell.bounds.size = CGSize(width: cell.bounds.size.width, height: height)
            cell.invalidateIntrinsicContentSize()
            
        }else if preguntaType == 3{
            
            var height :CGFloat = 0;
            let controller = SSRadioButtonsController();
            var count:Int = 0;
            var arr = Array<M13Checkbox>();
            
            for respuesta in encuesta.respuestas{
                height += 30;
                var checkbox = M13Checkbox(frame: CGRect(x: 15, y: height, width: 30, height: 30))
                checkbox.boxType =  M13Checkbox.BoxType.square;
                checkbox.checkedValue = respuesta;
                var label = UILabel(frame: CGRect(x: 45, y: height, width: 100, height: 30))
                label.textColor = UIColor.black;
                label.text = respuesta.respuesta
                (cell as! encuestaItem).stackview.addSubview(label);
                (cell as! encuestaItem).stackview.addSubview(checkbox);
                arr.append(checkbox)
            }
            
            encuesta.checkboxes = arr;
            cell.bounds.size = CGSize(width: cell.bounds.size.width, height: height)
            cell.invalidateIntrinsicContentSize()
            
        }else if preguntaType == 4{
            (cell as! encuestaItem).stackview.viewWithTag(5)?.isHidden = false
            photoCell =  (cell as! encuestaItem)
            photoCell.preguntaitem = encuesta
        }else if preguntaType == 5{
            (cell as! encuestaItem).stackview.viewWithTag(1)?.isHidden = false
            
        }else if preguntaType == 6{
            (cell as! encuestaItem).stackview.viewWithTag(3)?.isHidden = false
            
        }else{
            // (cell as! encuestaItem).contentView.isHidden = true;
        }
        
        
    }
    
    func clicked(_ sender: AnyObject){
        print("clicked")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "encuestaCell") as! encuestaItem
        
        var encuesta = self.encuestas[indexPath.row];
        
        (cell as! encuestaItem).stackview.viewWithTag(1)?.isHidden = true
        (cell as! encuestaItem).stackview.viewWithTag(2)?.isHidden = true
        (cell as! encuestaItem).stackview.viewWithTag(3)?.isHidden = true
        (cell as! encuestaItem).stackview.viewWithTag(4)?.isHidden = true
        (cell as! encuestaItem).stackview.viewWithTag(5)?.isHidden = true
        cell.delegate = self
        cell.preguntaitem = encuesta
        cell.pregunta.text = encuesta.pregunta;
        
        return cell
    }
    
    func takePhoto(sender: encuestaItem) {
        var controller = UIImagePickerController();
        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceType.camera;
        controller.navigationController?.isToolbarHidden = false
        self.present(controller, animated: true)
    }
    
    internal func takeSignature(sender: encuestaItem) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: true)
        signatureVC.subtitleText = "Porfavor Firme Aqui"
        signatureVC.title = "Firma"
        signatureVC.showsSaveSignatureOption = false;
        signatureVC.showsDate = false;
        
        let nav = UINavigationController(rootViewController: signatureVC)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.multipleImagePicker?.addImage(originalImage)
        
        var completion : RPMultipleImagePickerDoneCallback! = { array in
            print(array)
            self.photoCell.fotoQuantity.text =  " \(array!.count) de \(self.photoCell.preguntaitem.cantMinFotos)";
            //self.photoCell.maxFotos.text =  " \(self.photoCell.encuestaItem.maxFotos)";
            self.photoCell.preguntaitem.numFotos = "\(array!.count)"
            for image in array! {
                self.count += 1
                self.saveImageDocumentDirectory(image: image as! UIImage, name: "\(self.noped_usu_encuesta!)_\(self.encuesta.idPregunta!)_\(self.count).jpg")
            }
        }
        
        count = 0;
        self.multipleImagePicker?.doneCallback = completion;
        picker.pushViewController(self.multipleImagePicker!, animated: true)
    }
    func epSignature(_: EPSignatureViewController, didCancel error: NSError) {
        
    }
    func epSignature(_: EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect) {
        saveImageDocumentDirectory(image: signatureImage, name:  "\(self.noped_usu_encuesta!)_\(self.encuesta.idPregunta!)_\(self.count).jpg")
        boolfirmo = true;
    }
    
    func saveImageDocumentDirectory(image: UIImage!,name:String!){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        //store in sqllite
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"

        do{
            try SqlLiteManager.db?.run("INSERT INTO tab_fotocapturada(id_vis, id_usu, id_empv, id_encuesta, noped_usu, noped_usu_encuesta, nom_foto, id_pregunta, consecutivo, fecha_captura, id_sinc, fecha_sinc) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)", [1,User.sharedInstance.user_id!,empvId,encuesta.idPregunta!,noped_usu_encuesta!,noped_usu_encuesta!,paths,photoCell.preguntaitem.idPregunta!,self.count,dateFormatter.string(from: Date()),1,dateFormatter.string(from: Date())]);
            
            var result = try SqlLiteManager.db?.run("SELECT * FROM tab_fotocapturada");
            for row in result!{
                print(row)
            }
        }catch{
            
        }
    }
    
    func imageStored(){
     print("image Stored")
    }
    
    
}
