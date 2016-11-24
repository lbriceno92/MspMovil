//
//  NoVisitaViewController.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/24/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import UIKit

class NoVisitaViewController : BaseViewController,UITableViewDataSource, UITableViewDelegate{
    
    var arr = Array<Array<String>>();
    var selectedReason : String?;
    var initDate : String?;
    var finishDate : String?
    @IBOutlet weak var tableView: UITableView!
    var empvId : String!;
    
    
    override func viewDidLoad() {
        let button = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action:Selector("guardar"))
        self.navigationItem.rightBarButtonItem = button;
        
        do{
            var result = try SqlLiteManager.db?.prepare("SELECT * from tab_cnoventa");
            
            for r in result!{
                print(r)
                var a = Array<String>();
                print(r)
                a.append("\(r[2]!)")
                a.append("\(r[0]!)")
                arr.append(a)
            }
            tableView.reloadData()
        }catch{
            
        }
    }
    
    func prepareFord(empvId: String){
        self.empvId = empvId;
    }
    
    func guardar(){
        if selectedReason == nil{
            return
        }
        
        
        var firstQuery  = "SELECT tab_DiasXEmpv.id_diavis,*  FROM tab_empv,tab_DiasXEmpv,tab_FecVisitas WHERE tab_empv.id_empv=tab_DiasXEmpv.id_empv and  tab_DiasXEmpv.id_fecvis=tab_FecVisitas.id_fecvis and CAST(strftime('\("%")W',tab_empv.fecini_empv) AS FLOAT)*(52/tab_FecVisitas.lapso_fecvis)/52.0 - strftime('\("%")W',tab_empv.fecini_empv)*(52/tab_FecVisitas.lapso_fecvis)/52 == CAST(strftime('\("%")W','now','localtime') AS FLOAT)*(52/tab_FecVisitas.lapso_fecvis)/52.0 - strftime('\("%")W','now')*(52/tab_FecVisitas.lapso_fecvis)/52 and tab_diasXEmpv.id_diavis==\(getDayOfWeek()!)"
        do{
            var result = try SqlLiteManager.db?.prepare(firstQuery)
            var tipoRuta:Int = 0;
            
            for row in result! {
                tipoRuta = Int(row[0] as! Int64)
                if tipoRuta == getDayOfWeek() {
                    tipoRuta = 1;
                    print("dentro de ruta")
                }else{
                    tipoRuta = 2;
                    print("fuera de ruta")
                }
                print("\(tipoRuta)")
                
                
                break;
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
            var date = dateFormatter.string(from: Date())
            print(User.sharedInstance.user_id!)
            var insert = "INSERT INTO tab_Visitas (id_empv,cve_empv,id_usu,cve_usu,noped_usu,id_cnoventa,fechaini_vis,latitudini_vis,longitudini_vis,fechafin_vis,latitudfin_vis,longitudfin_vis,id_tpoRuta,id_sinc,fecha_sinc) " +
            "VALUES('0','0',\(User.sharedInstance.user_id!),'\(User.sharedInstance.userp!)',' ','\(selectedReason!)',Datetime('\(date)'),'0','0',Datetime('\(date)'),'0','0','\(tipoRuta)','1','\(date)')";

            print(insert)
            try SqlLiteManager.db?.run(insert)
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        }catch{
            
        }
        

                //        firstQuery = firstQuer
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "novisitaCell") as! SimpleCell
        
        cell.simpleText.text = arr[indexPath.row][0]
        
        return cell;
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedReason = arr[indexPath.row][1]
    }
    
    func getDayOfWeek()->Int? {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
        let myComponents = myCalendar?.components(.NSWeekdayCalendarUnit, from: todayDate as Date)
        let weekDay = myComponents?.weekday
        return weekDay
    }
    
}
