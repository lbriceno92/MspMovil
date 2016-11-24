//
//  GastoConsultaTableViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 11/9/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class GastoConsultaTableViewController : UITableViewController{
    
    var arr = Array<Array<String>>();
    
    override func viewDidLoad() {
   
    }
    override func viewWillAppear(_ animated: Bool) {
        var query = "SELECT folio_gastoseingresos, CASE Tipo_catgastos WHEN 'r' THEN 'Gastos' ELSE 'Ingresos'  END AS Tipo_catgastos, nom_gastoseingresos, comentario_gastoseingresos, importe_gastoseingresos FROM tab_gastoseingresos INNER JOIN tab_catgastos ON tab_gastoseingresos.id_catgastos = tab_catgastos.id_catgastos";
        do{
            var result = try SqlLiteManager.db?.run("SELECT folio_gastoseingresos, CASE Tipo_catgastos WHEN 'r' THEN 'Gastos' ELSE 'Ingresos'  END AS Tipo_catgastos, nom_gastoseingresos, comentario_gastoseingresos, importe_gastoseingresos FROM tab_gastoseingresos INNER JOIN tab_catgastos ON tab_gastoseingresos.id_catgastos = tab_catgastos.id_catgastos")
            
            for row in result!{
                var array = ["\(row[0]!)","\(row[1]!)","\(row[2]!)","\(row[3]!)","\(row[4]!)"]
                arr.append(array);
            }
            self.tableView.reloadData()
            
            self.tabBarController?.navigationItem.rightBarButtonItem = nil
            
        }catch{
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "gastosCell") as! GastosCell;
        cell.folio.text = arr[indexPath.row][0]
        cell.importe.text = arr[indexPath.row][4]
        cell.concepto.text = arr[indexPath.row][2]
        cell.tipo.text = arr[indexPath.row][1]

        return cell;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.arr.count
        return arr.count
    }
}
