//
//  ReciboController.swift
//  iOSApp
//
//  Created by Mr G on 6/5/20.
//  Copyright © 2020 Pegasus. All rights reserved.
//

import UIKit
import MaterialComponents.MDCButton

class ReciboController: UIViewController {
    //variables
    
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var btnConsultar: MDCButton!
    @IBOutlet weak var MainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowData(_ sender: UIButton) {
        if txtPlaca.text!.isEmpty {
            mensaje(texto: "La placa es requerida")
        }else{
            MainView.isHidden = false
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
