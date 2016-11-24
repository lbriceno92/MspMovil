 
 /*
  Copyright (c) 2016 Syed Absar Karim https://www.linkedin.com/in/syedabsar
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
 import Foundation
 
 /* Soap Client Generated from WSDL: http://64.151.103.133:80/WS_MBox/sincro.asmx?WSDL powered by http://www.wsdl2swift.com */
 
 open class SyedAbsarClient {
    
    let ipAddress: String;
    
    init(withIPAddress ipAddress:String){
        self.ipAddress = ipAddress;
    }
  
    
    
    /**
     Calls the SOAP Operation: OpenSession with Message based on OpenSession Object.
     
     - parameter openSession:  OpenSession Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opOpenSession(_ openSession : OpenSession , completionHandler: @escaping (OpenSessionResponse?, NSError?) -> Void) {
        print(openSession)
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:openSession><ns1:username>%@</ns1:username><ns1:password>%@</ns1:password><ns1:ApplicationName>%@</ns1:ApplicationName><ns1:seriepda_usu>%@</ns1:seriepda_usu><ns1:tipo_sincro>1</ns1:tipo_sincro><ns1:version>%@</ns1:version></ns1:openSession></SOAP-ENV:Body></SOAP-ENV:Envelope>",openSession.cpUsername!,openSession.cpPassword!,openSession.cpApplicationName!,openSession.cpSeriepda_usu!,openSession.cpVersion!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/openSession", soapMessage: soapMessage, soapVersion: "1", className:"OpenSessionResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? OpenSessionResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: GetLastCabURL with Message based on GetLastCabURL Object.
     
     - parameter getLastCabURL:  GetLastCabURL Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetLastCabURL(_ getLastCabURL : GetLastCabURL , completionHandler: @escaping (GetLastCabURLResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:getLastCabURL><ns1:deviceCabVersion>%@</ns1:deviceCabVersion></ns1:getLastCabURL></SOAP-ENV:Body></SOAP-ENV:Envelope>",getLastCabURL.cpDeviceCabVersion!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/getLastCabURL", soapMessage: soapMessage, soapVersion: "1", className:"GetLastCabURLResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetLastCabURLResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: GetLastDB with Message based on GetLastDB Object.
     
     - parameter getLastDB:  GetLastDB Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetLastDB(_ getLastDB : GetLastDB , completionHandler: @escaping (GetLastDBResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:getLastDB><ns1:deviceDBVersion>%@</ns1:deviceDBVersion></ns1:getLastDB></SOAP-ENV:Body></SOAP-ENV:Envelope>",getLastDB.cpDeviceDBVersion!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/getLastDB", soapMessage: soapMessage, soapVersion: "1", className:"GetLastDBResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetLastDBResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: GetLastCabURL2 with Message based on GetLastCabURL2 Object.
     
     - parameter getLastCabURL2:  GetLastCabURL2 Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetLastCabURL2(_ getLastCabURL2 : GetLastCabURL2 , completionHandler: @escaping (GetLastCabURL2Response?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:getLastCabURL2><ns1:deviceCabVersion>%@</ns1:deviceCabVersion><ns1:app_name>%@</ns1:app_name></ns1:getLastCabURL2></SOAP-ENV:Body></SOAP-ENV:Envelope>",getLastCabURL2.cpDeviceCabVersion!,getLastCabURL2.cpApp_name!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/getLastCabURL2", soapMessage: soapMessage, soapVersion: "1", className:"GetLastCabURL2Response", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetLastCabURL2Response,error) })
    }
    
    /**
     Calls the SOAP Operation: GetSchema with Message based on GetSchema Object.
     
     - parameter getSchema:  GetSchema Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetSchema(_ getSchema : GetSchema , completionHandler: @escaping (GetSchemaResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:getSchema><ns1:sessionId>%d</ns1:sessionId><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:getSchema></SOAP-ENV:Body></SOAP-ENV:Envelope>",getSchema.cpSessionId! ,getSchema.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/getSchema", soapMessage: soapMessage, soapVersion: "1", className:"GetSchemaResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetSchemaResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: GetRecords with Message based on GetRecords Object.
     
     - parameter getRecords:  GetRecords Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetRecords(_ getRecords : GetRecords , completionHandler: @escaping (GetRecordsResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:GetRecords><ns1:sessionId>%d</ns1:sessionId><ns1:table_name>%@</ns1:table_name><ns1:startRecord>%d</ns1:startRecord><ns1:ApplicationName>%@</ns1:ApplicationName><ns1:tipo_sincro>%d</ns1:tipo_sincro></ns1:GetRecords></SOAP-ENV:Body></SOAP-ENV:Envelope>",getRecords.cpSessionId!,getRecords.cpTable_name!,getRecords.cpStartRecord!,getRecords.cpApplicationName!,getRecords.cpTipo_sincro!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/GetRecords", soapMessage: soapMessage, soapVersion: "1", className:"GetRecordsResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetRecordsResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: UpdateRecords with Message based on UpdateRecords Object.
     
     - parameter updateRecords:  UpdateRecords Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opUpdateRecords(_ updateRecords : UpdateRecords , completionHandler: @escaping (UpdateRecordsResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:UpdateRecords><ns1:sessionId>0</ns1:sessionId><ns1:table_name>%@</ns1:table_name><ns1:RecordCollection>%@</ns1:RecordCollection><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:UpdateRecords></SOAP-ENV:Body></SOAP-ENV:Envelope>",updateRecords.cpSessionId!,updateRecords.cpTable_name!,updateRecords.cpRecordCollection!,updateRecords.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/UpdateRecords", soapMessage: soapMessage, soapVersion: "1", className:"UpdateRecordsResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? UpdateRecordsResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: CloseSession with Message based on CloseSession Object.
     
     - parameter closeSession:  CloseSession Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opCloseSession(_ closeSession : CloseSession , completionHandler: @escaping (CloseSessionResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:CloseSession><ns1:sessionId>%d</ns1:sessionId><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:CloseSession></SOAP-ENV:Body></SOAP-ENV:Envelope>",closeSession.cpSessionId!,closeSession.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/CloseSession", soapMessage: soapMessage, soapVersion: "1", className:"CloseSessionResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? CloseSessionResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: UpdateFotos with Message based on UpdateFotos Object.
     
     - parameter updateFotos:  UpdateFotos Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opUpdateFotos(_ updateFotos : UpdateFotos , completionHandler: @escaping (UpdateFotosResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:UpdateFotos><ns1:sessionid>0</ns1:sessionid><ns1:table_name>%@</ns1:table_name><ns1:RecordCollection>%@</ns1:RecordCollection><ns1:ApplicationName>%@</ns1:ApplicationName><ns1:Code>JUA=</ns1:Code></ns1:UpdateFotos></SOAP-ENV:Body></SOAP-ENV:Envelope>",updateFotos.cpSessionid!,updateFotos.cpTable_name!,updateFotos.cpRecordCollection!,updateFotos.cpApplicationName!,updateFotos.cpCode!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/UpdateFotos", soapMessage: soapMessage, soapVersion: "1", className:"UpdateFotosResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? UpdateFotosResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: EnviaImagenes with Message based on EnviaImagenes Object.
     
     - parameter enviaImagenes:  EnviaImagenes Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opEnviaImagenes(_ enviaImagenes : EnviaImagenes , completionHandler: @escaping (EnviaImagenesResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:EnviaImagenes><ns1:nombre_imagen>%@</ns1:nombre_imagen><ns1:ImgBytes>JUA=</ns1:ImgBytes><ns1:applicationName>%@</ns1:applicationName></ns1:EnviaImagenes></SOAP-ENV:Body></SOAP-ENV:Envelope>",enviaImagenes.cpNombre_imagen!,enviaImagenes.cpImgBytes!,enviaImagenes.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/EnviaImagenes", soapMessage: soapMessage, soapVersion: "1", className:"EnviaImagenesResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? EnviaImagenesResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: ConsultaInvServer with Message based on ConsultaInvServer Object.
     
     - parameter consultaInvServer:  ConsultaInvServer Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opConsultaInvServer(_ consultaInvServer : ConsultaInvServer , completionHandler: @escaping (ConsultaInvServerResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:ConsultaInvServer><ns1:idProd>0</ns1:idProd><ns1:idUsu>0</ns1:idUsu><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:ConsultaInvServer></SOAP-ENV:Body></SOAP-ENV:Envelope>",consultaInvServer.cpIdProd!,consultaInvServer.cpIdUsu!,consultaInvServer.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/ConsultaInvServer", soapMessage: soapMessage, soapVersion: "1", className:"ConsultaInvServerResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? ConsultaInvServerResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: ConsultaInvServerUbicacion with Message based on ConsultaInvServerUbicacion Object.
     
     - parameter consultaInvServerUbicacion:  ConsultaInvServerUbicacion Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opConsultaInvServerUbicacion(_ consultaInvServerUbicacion : ConsultaInvServerUbicacion , completionHandler: @escaping (ConsultaInvServerUbicacionResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:ConsultaInvServerUbicacion><ns1:idProd>0</ns1:idProd><ns1:idUsu>0</ns1:idUsu><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:ConsultaInvServerUbicacion></SOAP-ENV:Body></SOAP-ENV:Envelope>",consultaInvServerUbicacion.cpIdProd!,consultaInvServerUbicacion.cpIdUsu!,consultaInvServerUbicacion.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/ConsultaInvServerUbicacion", soapMessage: soapMessage, soapVersion: "1", className:"ConsultaInvServerUbicacionResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? ConsultaInvServerUbicacionResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: ConsultaInvProductosServer with Message based on ConsultaInvProductosServer Object.
     
     - parameter consultaInvProductosServer:  ConsultaInvProductosServer Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opConsultaInvProductosServer(_ consultaInvProductosServer : ConsultaInvProductosServer , completionHandler: @escaping (ConsultaInvProductosServerResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:ConsultaInvProductosServer><ns1:idProds><ns1:string>%@</ns1:string></ns1:idProds><ns1:idUsu>0</ns1:idUsu><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:ConsultaInvProductosServer></SOAP-ENV:Body></SOAP-ENV:Envelope>",consultaInvProductosServer.cpIdProds!,consultaInvProductosServer.cpIdUsu!,consultaInvProductosServer.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/ConsultaInvProductosServer", soapMessage: soapMessage, soapVersion: "1", className:"ConsultaInvProductosServerResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? ConsultaInvProductosServerResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: ConsultaReferencia with Message based on ConsultaReferencia Object.
     
     - parameter consultaReferencia:  ConsultaReferencia Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opConsultaReferencia(_ consultaReferencia : ConsultaReferencia , completionHandler: @escaping (ConsultaReferenciaResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:ConsultaReferencia><ns1:referencia>%@</ns1:referencia><ns1:modulo>%@</ns1:modulo><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:ConsultaReferencia></SOAP-ENV:Body></SOAP-ENV:Envelope>",consultaReferencia.cpReferencia!,consultaReferencia.cpModulo!,consultaReferencia.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/ConsultaReferencia", soapMessage: soapMessage, soapVersion: "1", className:"ConsultaReferenciaResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? ConsultaReferenciaResponse,error) })
    }
    
    /**
     Calls the SOAP Operation: GetRecordsUltimosPedidos with Message based on GetRecordsUltimosPedidos Object.
     
     - parameter getRecordsUltimosPedidos:  GetRecordsUltimosPedidos Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetRecordsUltimosPedidos(_ getRecordsUltimosPedidos : GetRecordsUltimosPedidos , completionHandler: @escaping (GetRecordsUltimosPedidosResponse?, NSError?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://tempuri.org/WS_MBOX/Service1\"><SOAP-ENV:Body><ns1:GetRecordsUltimosPedidos><ns1:id_session>0</ns1:id_session><ns1:ApplicationName>%@</ns1:ApplicationName></ns1:GetRecordsUltimosPedidos></SOAP-ENV:Body></SOAP-ENV:Envelope>",getRecordsUltimosPedidos.cpId_session!,getRecordsUltimosPedidos.cpApplicationName!)
        
        self.makeSoapConnection(String(format:"http://%@/WS_MBox/sincro.asmx",ipAddress), soapAction: "http://tempuri.org/WS_MBOX/Service1/GetRecordsUltimosPedidos", soapMessage: soapMessage, soapVersion: "1", className:"GetRecordsUltimosPedidosResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetRecordsUltimosPedidosResponse,error) })
    }
    
    
    
    /**
     Private Method: Make Soap Connection.
     
     - parameter soapLocation: String.
     - soapAction: String.
     - soapMessage: String.
     - soapVersion: String (1.1 Or 1.2).
     - className: String.
     - completionHandler: Handler.
     - returns: Void.
     */
    fileprivate func makeSoapConnection(_ soapLocation: String, soapAction: String, soapMessage: String,  soapVersion: String, className: String, completionHandler: @escaping (SyedAbsarObjectBase?, NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: soapLocation)!)
        let msgLength  = String(soapMessage.characters.count)
        let data = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        request.httpMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        // request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        request.httpBody = data
        
//        let task = URLRequest(url: request)
        let dataTask =  URLSession.shared.dataTask(with: request as URLRequest,  completionHandler: {
            data, response, error in
            
            if error != nil {
                print("/n error=\(error)")
                completionHandler(nil, error as NSError?)
                return
            }
            
            print("response = \(response)")
            
            let datastring = NSString(data: data!, encoding:String.Encoding.utf8.rawValue) as! String
            print(datastring)
            
            //This is a temporary code where it returns the actual XML Response
            //At the moment, response parsing and mapping is under progress
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            let currentResp = aClass.newInstance()
            currentResp.xmlResponseString = "\(datastring)"
            completionHandler(currentResp, error as NSError?)
            return
            
        })
        dataTask.resume()
        
        
    }
    
    
    
    
 }
 /**
  Open Session.
  */
 @objc(OpenSession)
 open class OpenSession : SyedAbsarObjectBase {
    
    
    /// Username
    var cpUsername: String?
    
    /// Password
    var cpPassword: String?
    
    /// Application Name
    var cpApplicationName: String?
    
    /// Seriepda_usu
    var cpSeriepda_usu: String?
    
    /// Tipo_sincro
    var cpTipo_sincro: Int?
    
    /// Version
    var cpVersion: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Username","Password","ApplicationName","Seriepda_usu","Tipo_sincro","Version"]
    }
 }
 
 /**
  Open Session Response.
  */
 @objc(OpenSessionResponse)
 open class OpenSessionResponse : SyedAbsarObjectBase {
    
    
    /// Open Session Result
    var cpOpenSessionResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["OpenSessionResult"]
    }
 }
 
 /**
  Get Last Cab U R L.
  */
 @objc(GetLastCabURL)
 open class GetLastCabURL : SyedAbsarObjectBase {
    
    
    /// Device Cab Version
    var cpDeviceCabVersion: String?
    
    override static func cpKeys() -> Array<String> {
        return ["DeviceCabVersion"]
    }
 }
 
 /**
  Get Last Cab U R L Response.
  */
 @objc(GetLastCabURLResponse)
 open class GetLastCabURLResponse : SyedAbsarObjectBase {
    
    
    /// Get Last Cab U R L Result
    var cpGetLastCabURLResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetLastCabURLResult"]
    }
 }
 
 /**
  Get Last D B.
  */
 @objc(GetLastDB)
 open class GetLastDB : SyedAbsarObjectBase {
    
    
    /// Device D B Version
    var cpDeviceDBVersion: String?
    
    override static func cpKeys() -> Array<String> {
        return ["DeviceDBVersion"]
    }
 }
 
 /**
  Get Last D B Response.
  */
 @objc(GetLastDBResponse)
 open class GetLastDBResponse : SyedAbsarObjectBase {
    
    
    /// Get Last D B Result
    var cpGetLastDBResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetLastDBResult"]
    }
 }
 
 /**
  Get Last Cab U R L2.
  */
 @objc(GetLastCabURL2)
 open class GetLastCabURL2 : SyedAbsarObjectBase {
    
    
    /// Device Cab Version
    var cpDeviceCabVersion: String?
    
    /// App_name
    var cpApp_name: String?
    
    override static func cpKeys() -> Array<String> {
        return ["DeviceCabVersion","App_name"]
    }
 }
 
 /**
  Get Last Cab U R L2 Response.
  */
 @objc(GetLastCabURL2Response)
 open class GetLastCabURL2Response : SyedAbsarObjectBase {
    
    
    /// Get Last Cab U R L2 Result
    var cpGetLastCabURL2Result: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetLastCabURL2Result"]
    }
 }
 
 /**
  Get Schema.
  */
 @objc(GetSchema)
 open class GetSchema : SyedAbsarObjectBase {
    
    
    /// Session Id
    var cpSessionId: CLong?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["SessionId","ApplicationName"]
    }
 }
 
 /**
  Get Schema Response.
  */
 @objc(GetSchemaResponse)
 open class GetSchemaResponse : SyedAbsarObjectBase {
    
    
    /// Get Schema Result
    var cpGetSchemaResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetSchemaResult"]
    }
 }
 
 /**
  Get Records.
  */
 @objc(GetRecords)
 open class GetRecords : SyedAbsarObjectBase {
    
    
    /// Session Id
    var cpSessionId: CLong?
    
    /// Table_name
    var cpTable_name: String?
    
    /// Start Record
    var cpStartRecord: CLong?
    
    /// Application Name
    var cpApplicationName: String?
    
    /// Tipo_sincro
    var cpTipo_sincro: Int?
    
    override static func cpKeys() -> Array<String> {
        return ["SessionId","Table_name","StartRecord","ApplicationName","Tipo_sincro"]
    }
 }
 
 /**
  Get Records Response.
  */
 @objc(GetRecordsResponse)
 open class GetRecordsResponse : SyedAbsarObjectBase {
    
    
    /// Get Records Result
    var cpGetRecordsResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetRecordsResult"]
    }
 }
 
 /**
  Update Records.
  */
 @objc(UpdateRecords)
 open class UpdateRecords : SyedAbsarObjectBase {
    
    
    /// Session Id
    var cpSessionId: CLong?
    
    /// Table_name
    var cpTable_name: String?
    
    /// Record Collection
    var cpRecordCollection: String?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["SessionId","Table_name","RecordCollection","ApplicationName"]
    }
 }
 
 /**
  Update Records Response.
  */
 @objc(UpdateRecordsResponse)
 open class UpdateRecordsResponse : SyedAbsarObjectBase {
    
    
    /// Update Records Result
    var cpUpdateRecordsResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UpdateRecordsResult"]
    }
 }
 
 /**
  Close Session.
  */
 @objc(CloseSession)
 open class CloseSession : SyedAbsarObjectBase {
    
    
    /// Session Id
    var cpSessionId: CLong?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["SessionId","ApplicationName"]
    }
 }
 
 /**
  Close Session Response.
  */
 @objc(CloseSessionResponse)
 open class CloseSessionResponse : SyedAbsarObjectBase {
    
    
    /// Close Session Result
    var cpCloseSessionResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["CloseSessionResult"]
    }
 }
 
 /**
  Update Fotos.
  */
 @objc(UpdateFotos)
 open class UpdateFotos : SyedAbsarObjectBase {
    
    
    /// Sessionid
    var cpSessionid: CLong?
    
    /// Table_name
    var cpTable_name: String?
    
    /// Record Collection
    var cpRecordCollection: String?
    
    /// Application Name
    var cpApplicationName: String?
    
    /// Code
    var cpCode: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Sessionid","Table_name","RecordCollection","ApplicationName","Code"]
    }
 }
 
 /**
  Update Fotos Response.
  */
 @objc(UpdateFotosResponse)
 open class UpdateFotosResponse : SyedAbsarObjectBase {
    
    
    /// Update Fotos Result
    var cpUpdateFotosResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UpdateFotosResult"]
    }
 }
 
 /**
  Envia Imagenes.
  */
 @objc(EnviaImagenes)
 open class EnviaImagenes : SyedAbsarObjectBase {
    
    
    /// Nombre_imagen
    var cpNombre_imagen: String?
    
    /// Img Bytes
    var cpImgBytes: String?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Nombre_imagen","ImgBytes","ApplicationName"]
    }
 }
 
 /**
  Envia Imagenes Response.
  */
 @objc(EnviaImagenesResponse)
 open class EnviaImagenesResponse : SyedAbsarObjectBase {
    
    
    /// Envia Imagenes Result
    var cpEnviaImagenesResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["EnviaImagenesResult"]
    }
 }
 
 /**
  Consulta Inv Server.
  */
 @objc(ConsultaInvServer)
 open class ConsultaInvServer : SyedAbsarObjectBase {
    
    
    /// Id Prod
    var cpIdProd: Int?
    
    /// Id Usu
    var cpIdUsu: Int?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["IdProd","IdUsu","ApplicationName"]
    }
 }
 
 /**
  Consulta Inv Server Response.
  */
 @objc(ConsultaInvServerResponse)
 open class ConsultaInvServerResponse : SyedAbsarObjectBase {
    
    
    /// Consulta Inv Server Result
    var cpConsultaInvServerResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["ConsultaInvServerResult"]
    }
 }
 
 /**
  Consulta Inv Server Ubicacion.
  */
 @objc(ConsultaInvServerUbicacion)
 open class ConsultaInvServerUbicacion : SyedAbsarObjectBase {
    
    
    /// Id Prod
    var cpIdProd: Int?
    
    /// Id Usu
    var cpIdUsu: Int?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["IdProd","IdUsu","ApplicationName"]
    }
 }
 
 /**
  Consulta Inv Server Ubicacion Response.
  */
 @objc(ConsultaInvServerUbicacionResponse)
 open class ConsultaInvServerUbicacionResponse : SyedAbsarObjectBase {
    
    
    /// Consulta Inv Server Ubicacion Result
    var cpConsultaInvServerUbicacionResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["ConsultaInvServerUbicacionResult"]
    }
 }
 
 /**
  Consulta Inv Productos Server.
  */
 @objc(ConsultaInvProductosServer)
 open class ConsultaInvProductosServer : SyedAbsarObjectBase {
    
    
    /// Id Prods
    var cpIdProds: String?
    
    /// Id Usu
    var cpIdUsu: Int?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["IdProds","IdUsu","ApplicationName"]
    }
 }
 
 /**
  Array Of String.
  */
 @objc(ArrayOfString)
 open class ArrayOfString : SyedAbsarObjectBase {
    
    
    /// String
    var cpString: String?
    
    override static func cpKeys() -> Array<String> {
        return ["String"]
    }
 }
 
 /**
  Consulta Inv Productos Server Response.
  */
 @objc(ConsultaInvProductosServerResponse)
 open class ConsultaInvProductosServerResponse : SyedAbsarObjectBase {
    
    
    /// Consulta Inv Productos Server Result
    var cpConsultaInvProductosServerResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["ConsultaInvProductosServerResult"]
    }
 }
 
 /**
  Consulta Referencia.
  */
 @objc(ConsultaReferencia)
 open class ConsultaReferencia : SyedAbsarObjectBase {
    
    
    /// Referencia
    var cpReferencia: String?
    
    /// Modulo
    var cpModulo: String?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Referencia","Modulo","ApplicationName"]
    }
 }
 
 /**
  Consulta Referencia Response.
  */
 @objc(ConsultaReferenciaResponse)
 open class ConsultaReferenciaResponse : SyedAbsarObjectBase {
    
    
    /// Consulta Referencia Result
    var cpConsultaReferenciaResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["ConsultaReferenciaResult"]
    }
 }
 
 /**
  Get Records Ultimos Pedidos.
  */
 @objc(GetRecordsUltimosPedidos)
 open class GetRecordsUltimosPedidos : SyedAbsarObjectBase {
    
    
    /// Id_session
    var cpId_session: Int?
    
    /// Application Name
    var cpApplicationName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Id_session","ApplicationName"]
    }
 }
 
 /**
  Get Records Ultimos Pedidos Response.
  */
 @objc(GetRecordsUltimosPedidosResponse)
 open class GetRecordsUltimosPedidosResponse : SyedAbsarObjectBase {
    
    
    /// Get Records Ultimos Pedidos Result
    var cpGetRecordsUltimosPedidosResult: String?
    
    override static func cpKeys() -> Array<String> {
        return ["GetRecordsUltimosPedidosResult"]
    }
 }
 
 
 /**
  A generic base class for all Objects.
  */
 open class SyedAbsarObjectBase : NSObject
 {
    var xmlResponseString: String?
    
    class func cpKeys() -> Array <String>
    {
        return []
    }
    
    required override public init(){}
    
    class func newInstance() -> Self {
        return self.init()
    }
    
    
 }
