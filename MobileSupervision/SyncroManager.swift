//
//  SyncroManager.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/11/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit

class  SyncroManager {
    
    let APPLICATION_NAME: String ;
    let PASSWORD :String ;
    
    var sqlManager: SqlLiteManager = SqlLiteManager();
    var soapClient : SyedAbsarClient;
    var downloadTables = Array<Array<String>>();
    var uploadTables = Array<Array<String>>();
    var sessionProgressHandler :((String?, Bool?,Bool?) -> Void)!;
    var progress = 0;
    var totalDownloadedTables = 0;
    
    init(withIPAddress ipAddress:String, appName:String, password:String){
        
        self.APPLICATION_NAME = appName;
        self.PASSWORD =  password;
        //        self.soapClient= SyedAbsarClient(withIPAddress: "64.151.103.133:80")
        self.soapClient = SyedAbsarClient(withIPAddress: ipAddress);
        uploadTables = Array<Array<String>>();
        downloadTables = Array<Array<String>>();
        sqlManager.connectToDB();
    }
    
    
    func evaluateSoapResponse(withResponse response:String?, error:NSError!, completionHandler: (String?, Bool) -> Void){
        var responseString = response;

        if (error != nil || response == nil) == true{
             responseString = "Error de dirección IP, verifica tu configuración e intentalo nuevamente";
        }
        
        var error : Bool = true;
        
        if (responseString?.isEmpty)! {
            responseString = "Tiempo de espera finalizado, no se obtiene respuesta del servidor; intentelo nuevamente";
            
        }else if (responseString?.contains("no address associated"))!{
            //error on request
            responseString = "TNo se logró la conexión con el servidor. Verifique su conexión a internet";
            
        }else if (responseString?.contains("EHOSTUNREACH"))!{
            //error on request
            responseString = "No se logró la conexión con el servidor. Verifique su conexión a internet";
            
        }else if (responseString?.contains("failed to connect"))!{
            //error on request
            responseString = "No se logró la conexión con el servidor. Verifique su conexión a internet";
            
        }else if (responseString?.contains("timeout"))!{
            //error on request
            responseString = "Tiempo de espera finalizado, no se obtiene respuesta del servidor; intentelo nuevamente";
            
        }else if (responseString?.contains("found"))!{
            //error on request
            responseString = "Error de dirección IP, verifica tu configuración e intentalo nuevamente";
            
        }else if (responseString?.contains("[-1]"))! || !(responseString?.contains("[0]"))!{
            //error on request
            responseString = responseString?.replacingOccurrences(of: "[-1]", with: "");
            
            if let startRange = responseString?.range(of: "["), let endRange = responseString?.range(of: "]"), startRange.upperBound <= endRange.lowerBound {
                let errorResponse = responseString?[startRange.upperBound..<endRange.lowerBound]
                //shows the error
                responseString = errorResponse;
                print(errorResponse)
            }
        }else {
            //success
            error = false;
        }
        
        if  error == true {
            sessionProgressHandler(responseString , error,false);
        }
        
        completionHandler(responseString , error);
    }
    
    
    func getStringArrayFromSoap(withResponse response:String, fromChar from:String, toChar to:String) -> Array<String>{
        
        var resultArray :Array = Array<String>();
        
        for (index, element) in response.characters.enumerated() {
            if String(element)  == from {
                let next = response.indexOf(to, startIndex: index);
                resultArray.append(response.substringWithRange(index+1..<next));
            }
        }
        return resultArray;
    }
    
    
    func getRegistersFromSoap(withResponse response:String) -> Array<Array<String>>{
        
        var resultArray :Array = Array<Array<String>>();
        let delimiter : String = "[RW]";
        var index = response.indexOf(delimiter, startIndex: 0);
        var secondIndex:Int;
        
        while index > 0 {
            secondIndex = response.indexOf("[/RW]", startIndex:index);
            let arrayString = self.getStringArrayFromSoap(withResponse:response.substringWithRange((index + delimiter.length)..<secondIndex), fromChar: "[", toChar: "]");
            resultArray.append(arrayString);
            index = response.indexOf(delimiter, startIndex: secondIndex);
        }
        
        return resultArray;
    }
    
    
    func getSessionID(_ completionHandler: @escaping (String?, Bool?,Bool?) -> Void){
        
        self.sessionProgressHandler = completionHandler;
        
        let openSessionObject = OpenSession();
        openSessionObject.cpUsername = "";
        openSessionObject.cpPassword = PASSWORD;
        openSessionObject.cpVersion = "1";
        openSessionObject.cpTipo_sincro = 1;
        openSessionObject.cpSeriepda_usu = "123456";
        openSessionObject.cpApplicationName = APPLICATION_NAME;
        
        
        soapClient.opOpenSession(openSessionObject) { (response, err) in
            var responseString = response?.xmlResponseString;
            
            self.evaluateSoapResponse(withResponse: responseString, error: err, completionHandler: { (string, hasError) in
                
                if (hasError){
                    print(string);
                    self.sessionProgressHandler(string,hasError,false);
                }else{
                    //success
                    var resultArray: Array<String> = self.getStringArrayFromSoap(withResponse: (response?.xmlResponseString)!,fromChar: "[",toChar: "]");
                    self.sessionProgressHandler(String(format: "Sesion iniciada, id de sesion: %@",resultArray[1]),hasError,false);

                    self.getSchema(withSessionId: resultArray[1]);
                }
                
            });
            
        };
    }
    
    
    func getSchema(withSessionId sessionId:String) -> Void{
        
        self.sessionProgressHandler("Obteniendo Registros",false,false);

        let schema: GetSchema = GetSchema();
        schema.cpApplicationName = "supervision_movil";
        schema.cpSessionId = Int(sessionId) ;
        
        soapClient.opGetSchema(schema) { (recordResponse, err) in
            let responseString = recordResponse?.xmlResponseString;
            

            
            self.evaluateSoapResponse(withResponse: responseString, error: err, completionHandler: { (string, hasError) in
                
                if hasError{
                    print(string!);
                }else{
                    
                    //success
                    print(responseString!);
                    
                    let resultArray = self.getRegistersFromSoap(withResponse: responseString! );
                    //            self.storeTables(withTableArray: resultArray);
                    
                    for arrayString in resultArray{
                        if arrayString[2] == "1" {
                            self.downloadTables.append(arrayString);
                        }else{
                            self.uploadTables.append(arrayString);
                        }
                    }
                    
                    self.sessionProgressHandler("Tablas de descarga : \(self.downloadTables.count)",false,false);
                    self.sessionProgressHandler("Tablas de subida : \(self.uploadTables.count)",false,false);

                    
                    self.syncDownloadTables(withSessionId: schema.cpSessionId!, completionHandler: { () in
                        print("finished synchronizing download tables")
                        self.sessionProgressHandler("finalizo sincronizacion de tablas",false,false);

                        
                        self.sqlManager.executeQueries(withSqlArray:[
                            "DELETE FROM tab_empv WHERE id_empv in (SELECT id_empv FROM tab_empv_old)",
                            "DELETE FROM tab_diasxempv WHERE id_empv in (SELECT id_empv FROM tab_empv_old)"
                            ,"DELETE FROM tab_empv_old"]
                            , completionHandler: { (done) in});
                        
                        for table:Array<String> in self.downloadTables {
                            self.sqlManager.executeQueries(withSqlArray: ["DELETE FROM \(table[1]) WHERE id_sinc = 5"], completionHandler: { (done) in
                                
                            });
                        }
                        
                        let closeSession = CloseSession();
                        closeSession.cpSessionId = schema.cpSessionId;
                        closeSession.cpApplicationName = self.APPLICATION_NAME;
                        self.soapClient.opCloseSession(closeSession, completionHandler: { (response, errr) in
                            var responseObjecy = self.getStringArrayFromSoap(withResponse: (response?.xmlResponseString)!, fromChar: "[", toChar: "]");
                            self.sessionProgressHandler("\(responseObjecy[1])",false,true);
                            
                                                      
                            print(responseObjecy[1]);
                        });
                    });
                    
                    
                    print (resultArray);
                }
                
            });
            
        };
    }
    
    
    func syncDownloadTables(withSessionId sessionId:Int, completionHandler: @escaping (Void) -> Void)  {
        var sqlArray = Array<String>();
        
        var getRecordsRequest : GetRecords;
    
        for (tableIndex, table) in downloadTables.enumerated(){
            
            //get records from soap for this 'table'
            getRecordsRequest = GetRecords();
            getRecordsRequest.cpSessionId = sessionId;
            getRecordsRequest.cpTable_name = table[1];
            getRecordsRequest.cpStartRecord = 0;
            getRecordsRequest.cpTipo_sincro = 1;
            getRecordsRequest.cpApplicationName = APPLICATION_NAME;
            
            self.sessionProgressHandler("Descargando Tabla \(getRecordsRequest.cpTable_name!)",false,false);

            
            soapClient.opGetRecords(getRecordsRequest, completionHandler: { (response, err) in
                
                let stringResult:String =  response!.xmlResponseString!;
                
                self.evaluateSoapResponse(withResponse: stringResult, error: err, completionHandler: { (string, hasError) in
                    
                    if hasError {
                        print(string!);
                    }else{
                        let recordsArray =  self.getRegistersFromSoap(withResponse:stringResult);
                        
//                        print(response!.xmlResponseString!);
                        
                    
                        var schemaTables = Array<Array<String>>();
                        //filling schematables
                        do{
                            // pragma tableinfo for each 'table'
                            if table[1] != ""{
                            var query = "PRAGMA table_info(\(table[1]))";
                            for r in try SqlLiteManager.db!.prepare(query) {
                                let array = Array<String>([" \(r[1]!)"," \(r[2]!)"]);
                                //add name and type to schema table
                                schemaTables.append(array);
                            }
                            }
                            
                        }catch{
                            print(String(format:"error executing statement "));
                        }
                        print(table[1])
                        if(table[1] == "TAB_ENCUESTA"){
                            print("this")
                        }
                    
                        for record in recordsArray{
                            
                            var row = 0;
                            var fields: String = "";
                            var values: String = "";
                            
                            for (field) in schemaTables{
                                fields = String(format:"%@, %@",fields,field[0]);
                                let type:String = field[1].lowercased();
                                
                                if type.contains("datetime") {
                                    values = String(format:"%@, DATETIME('%@')", values, record[row]);
                                } else if (type.lowercased().contains("varchar")) {
                                    
                                    values = String(format:"%@, '%@'", values, record[row].replacingOccurrences(of: "'", with: "", options:.literal , range: nil));
                                } else {
                                    values = String(format:"%@, %@", values, "\(record[row])");
                                }
                                
                                row += 1;
                            }
                            
                            //insert in sqllite each record
                            let sql = String(format:"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)", table[1], fields.substringWithRange(1..<fields.characters.count), values.substringWithRange(1..<values.characters.count));
                            sqlArray.append(sql);
                        }
                        print(sqlArray);
                        self.sqlManager.executeQueries(withSqlArray: sqlArray, completionHandler: { (done) in
                            
                        });
                        self.totalDownloadedTables += 1;
                        
                        self.progress = self.totalDownloadedTables;
                    
                        self.sessionProgressHandler("\(getRecordsRequest.cpTable_name!) descargada.",false,false);
                        sqlArray.removeAll();
            
                        if self.totalDownloadedTables == self.downloadTables.count{
                            completionHandler();
                        }
                    }
                });
            });
        }
    }
    
   
    
}
