//
//  Estancia.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//
import Foundation

class Estancia
{
    
    var placa: String = ""
    var hora_entrada: Double = 0.00
    var hora_salida : Double = 0.00
    var id: Int = 0
    
    init(id:Int, placa:String, hora_entrada:Double , hora_salida:Double)
    {
        self.id = id
        self.placa = placa
        self.hora_entrada = hora_entrada
        self.hora_salida = hora_salida
    }
    
}
