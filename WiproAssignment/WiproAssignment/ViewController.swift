//
//  ViewController.swift
//  WiproAssignment
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import UIKit
import Reachability

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchDataFromServer()
        
    }

}
private extension ViewController {
    
    func fetchDataFromServer() {
        
        guard Connectivity.isConnectedToInternet() else {
            
            presentAlertWithTitle(title: "Alert", message: "Please check your Internet connection.")
            return
        }
        
        FactService.fetchFactData { [unowned self](success, fact) in
            
            guard success, let fact = fact  else {
                
                self.presentAlertWithTitle(title: "Alert", message: "Error while fetching data.")
                return
            }
            
            print(fact)
        }
    }
    
}

