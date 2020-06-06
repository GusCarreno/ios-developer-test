//
//  Tipo.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import Foundation

class Tipo
{
    
    var nombre: String = ""
    var valor: Decimal = 0.00
    var id: Int = 0
    
    init(id:Int, nombre:String, valor:Decimal)
    {
        self.id = id
        self.nombre = nombre
        self.valor = valor
    }
    
}
