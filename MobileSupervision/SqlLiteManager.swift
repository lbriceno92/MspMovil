//
//  SqlLiteManager.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/8/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import SQLite

open class SqlLiteManager {
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    static var db : Connection?;
    var tables  = Array<String>();
    var dropTables  = Array<String>();
    
    func connectToDB(){
        
        struct Static {
            static var onceToken: Int = 0
        }
    
        do{
            SqlLiteManager.db = try Connection(String(format:"%@/db.sqlite3",self.path));
            self.setTables();
            self.setDropTables();
            
            //                self.executeQueries(withSqlArray: self.tables,
            self.executeQueries(withSqlArray: self.dropTables, completionHandler: { (done) in
                
            });
            self.executeQueries(withSqlArray: self.tables, completionHandler: { (done) in
                
            });
        }catch{
            print("error connecting to db")
        }
        
    }
    
    
    func executeQueries(withSqlArray sqlArray:Array<String>, completionHandler: (Bool) -> Void)  {
        let lockQueue = DispatchQueue(label: "com.test.LockQueue", attributes: [])
        lockQueue.sync {
            // code
            for stringSQL in sqlArray {
                //                do{
                let rowid = try! SqlLiteManager.db?.run(stringSQL);
                print("inserted id: \(rowid)")
                //                }catch{
                //                    print( stringSQL)
                //                }
            }
            
        }
    }
    
    func setTables() -> Void{
        tables.append("CREATE TABLE IF NOT EXISTS tab_Visitas (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_empv int, cve_empv varchar(250), id_usu int, cve_usu varchar(250), noped_usu varchar(250), id_cnoventa int, fechaini_vis DATETIME, latitudini_vis varchar(250), longitudini_vis varchar(250), fechafin_vis DATETIME, latitudfin_vis varchar(250), longitudfin_vis varchar(250), id_tpoRuta int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_visitasActividad (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_vis INT, noped_usu VARCHAR(100), noped_usu_actividad VARCHAR(100), id_tpoActividad INT, id_sinc INT, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Pedidos (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_empv int, cve_empv varchar(250), id_usu int, cve_usu varchar(250), id_vis int, noped_usu varchar(250), cant_ped NUMERIC(18,2), puntos NUMERIC(18,2), fecha_ped DATETIME, subtotal_ped NUMERIC(18,2), impuesto_ped NUMERIC(18,2), total_ped NUMERIC(18,2), desc_ped NUMERIC, pordes_ped NUMERIC, id_tpopago int, fentrega_ped DATETIME, coment_ped varchar(500), impresion_ped int, id_TpoRuta int, fpago_ped DATETIME, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_DetPedidos (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_ped int, noped_usu varchar(250), id_prod int, puntos NUMERIC(18,2), precio_prod NUMERIC(18,2), cant_prod NUMERIC(18,2), desc_prod NUMERIC(18,2), id_prom int, iva_prod NUMERIC (18,2), PorcenIva_Prod NUMERIC(18,2), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_PedidosAux (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_empv int, cve_empv varchar(250), id_usu int, cve_usu varchar(250), id_vis int, noped_usu varchar(250), cant_ped NUMERIC(18,2), puntos NUMERIC(18,2), fecha_ped DATETIME, subtotal_ped NUMERIC(18,2), impuesto_ped NUMERIC(18,2), total_ped NUMERIC(18,2), desc_ped NUMERIC, pordes_ped NUMERIC, id_tpopago int, fentrega_ped DATETIME, coment_ped varchar(500), impresion_ped int, id_TpoRuta int, fpago_ped DATETIME, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_DetPedidosAux (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_ped int, noped_usu varchar(250), id_prod int, puntos NUMERIC(18,2), precio_prod NUMERIC(18,2), cant_prod NUMERIC(18,2), desc_prod NUMERIC(18,2), id_prom int, iva_prod NUMERIC (18,2), PorcenIva_Prod NUMERIC(18,2), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Inventarios (_id int PRIMARY KEY, id_usu int, id_prod int, id_tpomov int, folio VARCHAR(100), inventario NUMERIC(18,2), saldo NUMERIC(18,2), fecha_inv DATETIME, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_configmodulos (_id int PRIMARY KEY, horariokilometraje varchar(1), horariokilometraje_Obligatorio varchar(1), devoluciones varchar(1), gastoseingresos varchar(1), existencias varchar(1), id_sinc int, fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_kilometraje (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_usu int, cve_usu varchar(100), hora_salida datetime,km_salida int, hora_lleagada datetime, km_llegada int, id_sinc int, fecha_sinc datetime   )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_devoluciones(_id INTEGER PRIMARY KEY AUTOINCREMENT, id_empv int, cve_empv varchar(100), id_usu int, cve_usu varchar(100), id_vis int, noped_usu varchar(100), cant_devoluciones int, fecha_devoluciones datetime, total_devoluciones int, impresion_devolciones int, id_sinc int, fecha_sinc datetime )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Detdevoluciones(_id INTEGER PRIMARY KEY AUTOINCREMENT, id_devoluciones int, noped_usu varchar(250), linea_detdevoluciones int, id_prod int, cve_prod varchar(250), precio_prod numeric(18,2),cant_prod numeric(18,2),PorcenIva_Prod numeric(18,2),id_catmotivo int,cve_catmotivos varchar(50),nom_catmotivos varchar(100),inventario varchar(1),cambio_fisico varchar(1),id_prodcambio int,cve_prodcambio varchar(250),cant_prodcambio numeric(18,2), id_sinc int, fecha_sinc DATETIME )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_existencias(_id INTEGER PRIMARY KEY AUTOINCREMENT, id_ped  int,noped_usu varchar(250),id_prod int,precio_prod numeric,cant_existencia numeric,iva_prod numeric,PorcenIva_Prod numeric,id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_existenciasAux (id_prod INT PRIMARY KEY, cant_prod NUMERIC(18,2), precio_prod numeric(18,2), iva_prod numeric(18,2), PorcenIva_Prod numeric(18,2) )");
        
        // TABLA QUE SE BORRA SIEMPRE QUE SE SINCRONIZA
        tables.append("CREATE TABLE IF NOT EXISTS tab_UltimosPedidos( id_empv INT, id_ped INT, id_prod INT, ultima_existencia NUMERIC(18,2), ultima_venta NUMERIC(18,2), penultima_existencia NUMERIC(18,2), penultima_venta NUMERIC(18,2) )");
        
        
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_catmotivos(id_catmotivos int PRIMARY KEY, cve_catmotivos varchar(50), nom_catmotivos varchar(100),inventario varchar(1), cambio_fisico varchar(1), id_sinc int, fecha_sinc datetime )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Categorias (id_cat int PRIMARY KEY, cve_cat varchar(250), nom_cat varchar(500), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_cnoventa (id_cnoventa int PRIMARY KEY, cve_cnoventa varchar(25) , nom_cnoventa varchar(100), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_DiasVisitas (id_diavis int PRIMARY KEY, nom_diavis varchar (100), id_sinc  int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_DiasXEmpv (id_diasxempv int PRIMARY KEY, id_empv int, id_diavis int, id_fecvis int, ordenlogico_empv int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Empv (id_empv int PRIMARY KEY, cve_empv varchar(250), nom_empv varchar(500), id_tpoempv int, id_tponeg int, contacto_empv varchar(500), RFC_empv varchar(500), id_zona int, id_area int, id_sector int, lista_precio varchar(50), direc_empv varchar(500), ref_empv varchar(500), provin_empv varchar(500), ciudad_empv varchar(500), tel_empv varchar(500), movil_empv varchar(500), fecini_empv DATETIME, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_FecVisitas (id_fecvis int PRIMARY KEY, cve_fecvis varchar(100), nom_fecvis varchar(250), lapso_fecvis int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Ivas (id_iva int PRIMARY KEY, cve_iva  varchar(250), nom_iva varchar(250), imp_iva NUMERIC(18,2), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Marcas (id_marca int PRIMARY KEY, id_cat int, id_subcat int, cve_marca varchar(250), nom_marca varchar(500), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Productos (id_prod int PRIMARY KEY, cve_prod varchar(250), id_cat int, id_subcat int, id_marca int, nom_prod varchar(500), precio_prod1 NUMERIC(18,2), punto_1 int, precio_prod2 NUMERIC(18,2), punto_2 int, precio_prod3 NUMERIC(18,2), punto_3, pzasxcaja_prod NUMERIC(18,2), id_iva int, codigo_barras varchar(250), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Promociones (id_prom int PRIMARY KEY, cve_prom VARCHAR(250), id_prod int, id_usu int, id_empv int, desc_prom NUMERIC(18,2), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_SubCategorias (id_subcat int PRIMARY KEY, id_cat int, cve_subcat varchar(500), nom_subcat varchar(500), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_TpoEmpv (id_tpoempv int PRIMARY KEY, cve_tpoempv varchar(25), nomtpoempv varchar(100), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_TpoNegocios (id_tponeg int PRIMARY KEY, cve_tponeg varchar(25), nom_tponeg varchar(100), id_sinc int, fecha_sinc DATETIME)");
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_TpoPagos(id_tpoPago int PRIMARY KEY, cve_tpopago varchar(10), nom_tpopago varchar(50), id_sinc int, fecha_sinc DATETIME)");
        
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_tpoMovimientos(id_tpomov int PRIMARY KEY, nom_tpomovimiento varchar(100), id_sinc int, fecha_sinc Datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_empv_old (id_empv_old int PRIMARY KEY, id_empv int, cve_empv varchar(100), id_sector int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Usuarios (id_usu int PRIMARY KEY, cve_usu varchar(20), nom_usu varchar(50), apat_usu varchar(50), amat_usu varchar(50), id_tpousu int, id_zona int, id_area int, id_sector int, clave_usu varchar(20), pass_usu varchar(20), direc_usu varchar(200), tel_usu varchar(25), movil_usu varchar(50), seriepda_usu varchar(100), ipserver varchar(50),  id_usuSup int, id_menus varchar(100), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_datosimp (id_config int PRIMARY KEY, cve_config varchar(50), cabecero varchar(4000), pie varchar(4000), copia int, codigo int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_ConfigTags (id_config INT PRIMARY KEY, descripcion VARCHAR(100), valor VARCHAR(100), id_sinc INT, fecha_sinc DATETIME) ");
        tables.append("CREATE TABLE IF NOT EXISTS tab_ConfigVentas(id_config INT PRIMARY KEY, ventasConInventario INT, ventasConDecimales INT, id_sinc INT, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_gps_monitoreo(_id INTEGER PRIMARY KEY AUTOINCREMENT, id_usu INT, id_zona INT, id_area INT,cve_usu varchar(100), nom_usu varchar(100), apat_usu varchar(50), amat_usu varchar(50) , lat_anterior varchar(100), long_anterior varchar(100), lat_actual varchar(100), long_actual varchar(100), distancia_sensor_mts NUMERIC(18,2), batery int, señal varchar(100), flag_geocerca VARCHAR(100), flag_velocidad VARCHAR(100), fecha_gps DATETIME, id_sinc int, fecha_sinc DTETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_catgastos(id_catgastos INT PRIMARY KEY, nom_catgastos varchar(100),Tipo_catgastos varchar(1),comentario_catgastos varchar(1),id_sinc INT, fecha_sinc datetime )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_gastoseingresos(_id INTEGER PRIMARY KEY, id_usu INT,cve_usu varchar(100) ,folio_gastoseingresos varchar(250),id_catgastos int,nom_gastoseingresos varchar(100), importe_gastoseingresos numeric,comentario_gastoseingresos varchar(250), fecha_gastoseingresos datetime,id_sinc int, fecha_sinc datetime )");
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_preguntatipo(id_preguntatipo INT PRIMARY KEY, tipo_pregunta varchar(500),flag_sino int, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_encuesta( id_encuesta INT PRIMARY KEY,nom_encuesta varchar(150),fecha_inicio datetime,fecha_vencimiento datetime,id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_pregunta(id_pregunta INTEGER PRIMARY KEY,id_preguntatipo int,pregunta varchar(500),cantidad_foto int,cant_minfoto int,ID_SINC int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_preguntarespuesta(id_respuesta PRIMARY KEY, id_pregunta int,respuesta varchar(500),flag_comentario int,id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_preguntaencuesta(idpregenc int PRIMARY KEY, id_encuesta int,id_pregunta int,id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_fotocapturada(_id INTEGER PRIMARY KEY AUTOINCREMENT,  id_vis int,id_usu int,id_empv int,id_encuesta int,noped_usu varchar(100),noped_usu_encuesta varchar(100),nom_foto varchar(199),id_pregunta int,consecutivo int,fecha_captura datetime,id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_encuestaRespuestas (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_vis int,id_usu int,id_empv int,id_encuesta int,noped_usu varchar(100),noped_usu_encuesta varchar(100),fecha_captura datetime,id_pregunta int,respuesta_si_no int,id_respuesta int,id_foto int,resp_comentario varchar(100),id_sinc int,fecha_sinc datetime)");
        
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_configEx(id_configEx INT PRIMARY KEY , id_usu INT, tiempoGPS_ConfigEx INT, SincAutoma_ConfigEx INT, Adicional1_ConfigEx varchar(50),  Activo INT, id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_catGeocerca(id_catGeocerca int PRIMARY KEY , nom_catGeocerca varchar(100), id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_detGeocerca(id_detGeocerca int PRIMARY KEY , id_catGeocerca INT, orden_detGeocerca INT,latitud varchar(100),longitud varchar(100),id_sinc int, fecha_sinc DATETIME)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_usuGeocerca(id_usuGeocerca int PRIMARY KEY , id_usuario INT, id_catGeocerca INT,id_sinc int, fecha_sinc DATETIME)");
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_bancos (id_banco int PRIMARY KEY, banco varchar(100), habilitado int, id_sinc int, fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_Cobranzas (id_cobranza int PRIMARY KEY, id_usu int, id_empv int, factura varchar(50), importe numeric(18,2), Saldo numeric(18,2), promesa_pago numeric(18,2), id_frecVis int, fecha_fact datetime, fecha_venc datetime, dias_venc int, id_sinc int, fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_PagoCobranza (_id INTEGER PRIMARY KEY AUTOINCREMENT, id_cab int, noped_usu varchar(250), id_cobranza int, id_tpopago int, id_banco int, Factura varchar(100), Descu numeric(18,2), Deposito_cli numeric(18,2), Abono numeric(18,2), numCheque varchar(100), fecha datetime, fecha_captura datetime, fecha_envio datetime, id_usu int, cve_usu varchar(200), id_empv int, cve_empv varchar(200), importe_original numeric(18,2), saldo numeric(18,2), id_tpoRuta int, id_sinc int, fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_promPago(id_promPago int NOT NULL PRIMARY KEY,id_usu int,cve_usu varchar(200),id_empv int,cve_empv varchar(200),folio varchar(200),factura varchar(200),fecha_cap datetime,fecha_pago datetime,motivo varchar(500),firma varchar(200),status varchar(200),id_sinc int,fecha_sinc datetime)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_TpoPagosCobranzas ( id_tpopago int PRIMARY KEY, id_emp int, cve_tpopago varchar (25), nom_tpopago varchar (50), id_sinc int, fecha_sinc datetime )");
        
        tables.append("CREATE TABLE IF NOT EXISTS TAB_VERSION(_id INTEGER PRIMARY KEY AUTOINCREMENT, CODE_VERSION INT, VERSION_NAME VARCHAR(20), ID_SINC INT, FECHA_SINC DATETIME )");
        tables.append("CREATE TABLE IF NOT EXISTS tab_imp (_id INTEGER PRIMARY KEY AUTOINCREMENT, nombre_imp varchar (100), mac_imp varchar(50), tam_papel int)");
        tables.append("CREATE TABLE IF NOT EXISTS tab_ipconfig (id_ip int PRIMARY KEY, ip_server varchar(300), appname varchar(100))");
        
        tables.append("CREATE TABLE IF NOT EXISTS tab_fechas(_id INTEGER PRIMARY KEY AUTOINCREMENT, horaGPS datetime);");
        
    }
    
    func setDropTables()-> Void{
        dropTables.append("DROP TABLE IF EXISTS tab_bancos");
        dropTables.append("DROP TABLE IF EXISTS tab_Cobranzas");
        dropTables.append("DROP TABLE IF EXISTS tab_PagoCobranza");
        dropTables.append("DROP TABLE IF EXISTS tab_promPago");
        dropTables.append("DROP TABLE IF EXISTS tab_TpoPagosCobranzas");
        dropTables.append("DROP TABLE IF EXISTS tab_Visitas");
        dropTables.append("DROP TABLE IF EXISTS tab_visitasActividad");
        dropTables.append("DROP TABLE IF EXISTS tab_Pedidos");
        dropTables.append("DROP TABLE IF EXISTS tab_DetPedidos");
        dropTables.append("DROP TABLE IF EXISTS tab_PedidosAux");
        dropTables.append("DROP TABLE IF EXISTS tab_DetPedidosAux");
        dropTables.append("DROP TABLE IF EXISTS tab_Inventarios");
        dropTables.append("DROP TABLE IF EXISTS tab_Categorias");
        dropTables.append("DROP TABLE IF EXISTS tab_cnoventa");
        dropTables.append("DROP TABLE IF EXISTS tab_DiasVisita");
        dropTables.append("DROP TABLE IF EXISTS tab_DiasXEmpv");
        dropTables.append("DROP TABLE IF EXISTS tab_Empv");
        dropTables.append("DROP TABLE IF EXISTS tab_FecVisitas");
        dropTables.append("DROP TABLE IF EXISTS tab_Ivas");
        dropTables.append("DROP TABLE IF EXISTS tab_Marcas");
        dropTables.append("DROP TABLE IF EXISTS tab_Productos");
        dropTables.append("DROP TABLE IF EXISTS tab_Promociones");
        dropTables.append("DROP TABLE IF EXISTS tab_SubCategorias");
        dropTables.append("DROP TABLE IF EXISTS tab_TpoEmpv");
        dropTables.append("DROP TABLE IF EXISTS tab_TpoNegocios");
        dropTables.append("DROP TABLE IF EXISTS tab_TpoPagos");
        dropTables.append("DROP TABLE IF EXISTS tab_tpoMovimientos");
        dropTables.append("DROP TABLE IF EXISTS tab_empv_old");
        dropTables.append("DROP TABLE IF EXISTS tab_Usuarios");
        dropTables.append("DROP TABLE IF EXISTS tab_datosimp");
        dropTables.append("DROP TABLE IF EXISTS tab_imp");
        dropTables.append("DROP TABLE IF EXISTS tab_ConfigTags");
        dropTables.append("DROP TABLE IF EXISTS TAB_VERSION");
        dropTables.append("DROP TABLE IF EXISTS tab_ConfigVentas");
        dropTables.append("DROP TABLE IF EXISTS tab_gps_monitoreo");
        
        dropTables.append("DROP TABLE IF EXISTS tab_catGeocerca");
        dropTables.append("DROP TABLE IF EXISTS tab_detGeocerca");
        dropTables.append("DROP TABLE IF EXISTS tab_usuGeocerca");
        dropTables.append("DROP TABLE IF EXISTS tab_configEx");
        dropTables.append("DROP TABLE IF EXISTS tab_configmodulos");
        dropTables.append("DROP TABLE IF EXISTS tab_Detdevoluciones");
        dropTables.append("DROP TABLE IF EXISTS tab_catmotivos");
        //  dropTables.append("DROP TABLE IF EXISTS tab_kilometraje");
        dropTables.append("DROP TABLE IF EXISTS tab_gastoseingresos");
        dropTables.append("DROP TABLE IF EXISTS tab_preguntatipo");
        dropTables.append("DROP TABLE IF EXISTS tab_encuesta");
        dropTables.append("DROP TABLE IF EXISTS tab_pregunta");
        dropTables.append("DROP TABLE IF EXISTS tab_preguntarespusta");
        dropTables.append("DROP TABLE IF EXISTS tab_preguntaencuesta");
        dropTables.append("DROP TABLE IF EXISTS tab_fotocapturada");
        dropTables.append("DROP TABLE IF EXISTS tab_encuestaRespuestas");
        
    }
    
    
}
