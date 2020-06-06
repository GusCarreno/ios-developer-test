//
//  Vehiculo.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation

class Vehiculo
{
    
    var placa: String = ""
    var tipo: Int = 0
    var id: Int = 0
    
    init(id:Int, placa:String, tipo:Int)
    {
        self.id = id
        self.placa = placa
        self.tipo = tipo
    }
    
}
