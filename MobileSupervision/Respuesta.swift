//
//  Respuesta.swift
//  MobileSupervision
//
//  Created by lbriceno on 10/30/16.
//  Copyright © 2016 MBOX. All rights reserved.
//

import Foundation
class Respuesta {
    var idRespuesta:Int?,respuesta:String? ,flagComentario:Int?,comentario:String?,idVisita:Int?,selected:Bool?;
    var radioController : SSRadioButtonsController?;
    var checkbox :M13Checkbox?;
    
    init(withId:Int, respuesta:String,flagComentario:Int,comentario:String,idVisita:Int,selected:Bool){
        self.idRespuesta = withId;
        self.respuesta = respuesta;
        self.flagComentario = flagComentario;
        self.comentario = comentario;
        self.selected = selected;
    }
}
