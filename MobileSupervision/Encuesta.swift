//
//  Encuesta.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/30/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
import UIKit


class Encuesta {
    var idPregunta:String?,pregunta:String?,idPreguntaTipo:String?,maxFotos:String?,numFotos:String?,cantMinFotos:String?,abierta:String?,fechaInit:String?,fechaFin:String?;
    var posSiNo :Int?;
    var segmentedController: UISegmentedControl?;
    var checkboxes = Array<M13Checkbox>();
    var respuestas = Array<Respuesta>();
    
    init(idPregunta :String, nombre:String, fechaInit:String, fechaFin:String){
        self.idPregunta = idPregunta;
        self.pregunta = nombre;
        self.fechaInit = fechaInit;
        self.fechaFin = fechaFin;
    }
    
    init(idPregunta :String, nombre:String,idPreguntaTipo:String,maxFotos:String,numFotos:String, cantMinFotos:String, abierta:String, pos:Int){
        self.idPregunta = idPregunta;
        self.pregunta = nombre;
        self.idPreguntaTipo = idPreguntaTipo;
        self.maxFotos = maxFotos
        self.numFotos = numFotos
        self.cantMinFotos = cantMinFotos
        self.abierta = abierta
        self.posSiNo = pos
    }
}
