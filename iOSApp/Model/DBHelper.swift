//
//  DBHelper.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//
import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "iOSApp.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let TableStringVehiculo = "CREATE TABLE IF NOT EXISTS tbl_vehiculos(id_vehiculo INTEGER PRIMARY KEY AUTOINCREMENT, placa varchar , tipo INTEGER)"
        var createTableVehiculo: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, TableStringVehiculo, -1, &createTableVehiculo, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableVehiculo) == SQLITE_DONE
            {
                print("vehiculos table created.")
            } else {
                print("vehiculos table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableVehiculo)
        //tbl_estancia
        let TableStringEstancia = "CREATE TABLE IF NOT EXISTS tbl_estancia(id_estancia INTEGER PRIMARY KEY AUTOINCREMENT, placa varchar , hora_entrada DATETIME , hora_salida DATETIME)"
        var createTableEstancia: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, TableStringEstancia, -1, &createTableEstancia, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableEstancia) == SQLITE_DONE
            {
                print("estancia table created.")
            } else {
                print("estancia table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableEstancia)
        //tbl_tipo_vehiculos
        let TableStringTipo = "CREATE TABLE IF NOT EXISTS tbl_tipo_vehiculos(id_tipo INTEGER PRIMARY KEY AUTOINCREMENT, nombre varchar , valor DECIMAL)"
        var createTableTipo: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, TableStringTipo, -1, &createTableTipo, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableTipo) == SQLITE_DONE
            {
                print("tipo table created.")
            } else {
                print("tipo table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableTipo)
    }
    
    //VEHICULO
    func insertVehiculo(placa:String, tipo:Int)
    {
       
        let insertStatementString = "INSERT INTO tbl_vehiculo (PLACA, TIPO) VALUES (?, ?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (placa as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(tipo))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readVehiculo() -> [Vehiculo] {
        let queryStatementString = "SELECT * FROM tbl_vehiculo"
        var queryStatement: OpaquePointer? = nil
        var psns : [Vehiculo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let idVeh = sqlite3_column_int(queryStatement, 0)
                let placaVeh = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let tipoVeh = sqlite3_column_int(queryStatement, 2)
                psns.append(Vehiculo(id: Int(idVeh), placa: placaVeh, tipo: Int(tipoVeh)))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func readVehi(placa:String) -> [Vehiculo] {
    let queryStatementString = "SELECT * FROM tbl_vehiculo WHERE placa= '" + placa + "'"
    var queryStatement: OpaquePointer? = nil
    var psns : [Vehiculo] = []
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            let idVeh = sqlite3_column_int(queryStatement, 0)
            let placaVeh = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
            let tipoVeh = sqlite3_column_int(queryStatement, 2)
            psns.append(Vehiculo(id: Int(idVeh), placa: placaVeh, tipo: Int(tipoVeh)))
            
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    sqlite3_finalize(queryStatement)
     return psns
    }
    //ESTANCIAS
    func insertEstancia(placa:String, entrada:Double)
    {
       
        let insertStatementString = "INSERT INTO tbl_estancia (PLACA, TIPO) VALUES (?, ?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (placa as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, Double(entrada))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func updateEstancia(id:Int , placa:String, salida:Double)
    {
       
        let insertStatementString = "UPDATE tbl_estancia SET (PLACA, TIPO) VALUES (?, ?) WHERE id_estancia = ?"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (placa as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, Double(salida))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readEstancias() -> [Estancia] {
        let queryStatementString = "SELECT * FROM tbl_estancia"
        var queryStatement: OpaquePointer? = nil
        var psns : [Estancia] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let idEst = sqlite3_column_int(queryStatement, 0)
                let placaEst = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let entrada = sqlite3_column_double(queryStatement, 2)
                let salida = sqlite3_column_double(queryStatement, 3)
                psns.append(Estancia(id: Int(idEst), placa: placaEst, hora_entrada:Double(entrada), hora_salida: Double(salida)))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    //TIPO
    func insertTipo(nombre:String, valor:Double)
    {
       
        let insertStatementString = "INSERT INTO tbl_tipo_vehiculo (nombre, valor) VALUES (?, ?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (nombre as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 2, Double(valor))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readTipo() -> [Tipo] {
        let queryStatementString = "SELECT * FROM tbl_tipo_vehiculos"
        var queryStatement: OpaquePointer? = nil
        var psns : [Tipo] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let idTip = sqlite3_column_int(queryStatement, 0)
                let nombreTip = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let valorTip = sqlite3_column_double(queryStatement, 2)
                psns.append(Tipo(id: Int(idTip), nombre: nombreTip, valor: Decimal(valorTip)))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    //DELETE
    func deleteByID(id:Int, table:String, campo:String) {
        let deleteStatementStirng = "DELETE FROM " + table + " WHERE " + campo + " = ?"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
