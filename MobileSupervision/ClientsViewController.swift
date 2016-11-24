//
//  ClientsViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/23/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import UIKit

class ClientsViewControler : BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    var dbManager: SqlLiteManager = SqlLiteManager();
    var myRoute = Array<Client>();
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var keyTxt: UITextField!
    @IBOutlet weak var contactTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var selectedTable = 1;
    var selectedClient : Client?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let button = UIBarButtonItem(title: "Buscar", style: .plain, target: self, action:Selector("buscar"))
        self.navigationItem.rightBarButtonItem = button;
        buscar();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "startClient"{
            let vc = segue.destination as! ClientInfoViewController;
            vc.prepareForClient(client: self.selectedClient!);
        }
    }
    
    /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "startClient"{
            if self.selectedClient != nil {
                return true
            }else{
                return false
            }
        }
        return false
    }*/
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRoute.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell") as! ClientTableViewCell;
        cell.name.text = myRoute[indexPath.row].name
        cell.count.text = String.init(format: " %d ", (myRoute[indexPath.row].order));
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedClient = self.myRoute[indexPath.row]
        performSegue(withIdentifier: "startClient", sender: self)
    }
    
    
    func buscar(){
        let buscarPorNombre:String = nameTxt.text!,buscarPorContacto:String = contactTxt.text!,buscarPorClave:String = keyTxt.text!;
        var query:String;
        self.selectedClient = nil;
        
        query =  "SELECT tab_empv.id_empv, tab_empv.nom_empv, tab_empv.contacto_empv, tab_empv.fecini_empv, tab_DiasXEmpv.id_diavis, tab_DiasXEmpv.ordenlogico_empv, tab_empv.tel_empv, tab_empv.movil_empv,tab_empv.direc_empv, cve_empv  FROM tab_empv,tab_DiasXEmpv,tab_FecVisitas WHERE tab_empv.id_empv=tab_DiasXEmpv.id_empv and  tab_DiasXEmpv.id_fecvis=tab_FecVisitas.id_fecvis ";
        if selectedTable == 1{
            query = query.appending(" and nom_empv like '%"+buscarPorNombre+"%' and contacto_empv like '%"+buscarPorContacto+"%' and cve_empv like '%"+buscarPorClave+"%' ")
        }
        else if selectedTable == 2{
            query = query.appending(" and nom_empv like '%"+buscarPorNombre+"%' and contacto_empv like '%"+buscarPorContacto+"%' and cve_empv like '%"+buscarPorClave+"%' and tab_empv.id_empv not in (select tab_visitas.id_empv from tab_visitas)")
        }
        
        query = query.appending(" GROUP BY  tab_empv.id_empv  ORDER BY tab_DiasXEmpv.ordenlogico_empv ")
        print(query)
        myRoute.removeAll();
        
        do{
            for r in try SqlLiteManager.db!.prepare(query) {
                print(r)
                let client = Client(withName: r[1] as! String, order: r[5] as! Int64, contact: r[2] as! String,dir : r[8] as! String,phone : r[6] as! String,cell: r[7] as! String,key : r[9] as! String)
                myRoute.append(client)
            }
            self.tableView.reloadData()
        }catch{
            
        }
        
    }
    
}
