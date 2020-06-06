//
//  Globales.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

func currentTime() -> String {
    let now = Date()
    let components = Calendar.current.dateComponents([.hour, .minute], from: now)
    let hour = components.hour ?? 0
    let minute = components.minute ?? 0
    return "\(hour):\(minute)"
}

class Global {
   ///11 elements
    static var Placa : String = ""
    static var BtnCerrar = "CERRAR"
    static var BtnConti  = "CONTINUAR"
}

func mensaje(texto : String){
       let message = MDCSnackbarMessage()
       message.text = texto
       MDCSnackbarManager.show(message)
   }
