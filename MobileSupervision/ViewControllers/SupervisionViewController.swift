//
//  SupervisionViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/24/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class SupervisionViewController : BaseViewController , UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var tableView: UITableView!
    var client: Client?;
    var array =  Array<Encuesta>();
    var selectedEncuesta : Encuesta?;
    
    override func viewDidLoad() {
        do{
            let stmt = try SqlLiteManager.db?.prepare("SELECT ID_ENCUESTA, NOM_ENCUESTA, STRFTIME('%d/%m/%Y', FECHA_INICIO) as FECHA_INICIO, STRFTIME('%d/%m/%Y', FECHA_VENCIMIENTO) as FECHA_VENCIMIENTO FROM TAB_ENCUESTA")
            print(stmt!)
            for row  in stmt! {
                print(row)
                let encuesta = Encuesta(idPregunta: "\(row[0]!)", nombre: "\(row[1]!)", fechaInit: "\(row[2]!)", fechaFin: "\(row[3]!)") ;
                array.append(encuesta)
            }
            self.tableView.reloadData();
            
        }catch{
            
        }
    }
    
    
    func prepareForClient(client:Client){
        self.client = client;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "encuestaSegue", let destination = segue.destination as? EncuestaViewcontroller {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                var encuesta = self.array[indexPath.row]
                destination.prepareFor(encuesta: encuesta , empvId: (client?.key)!);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEncuesta = self.array[indexPath.row]
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell") as! DocTableViewCell;
        let docname = array[indexPath.row].pregunta;
        let initDate = array[indexPath.row].fechaInit;
        let finishDate = array[indexPath.row].fechaFin;
        cell.name.text = docname
        cell.initDate.text = initDate
        cell.finishDate.text = finishDate
        
        return cell;
    }
    

}
