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
    
    var factTableView: UITableView!
    var factData: Fact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        designUIElements()
        fetchDataFromServer()
    }
    
}

private extension ViewController {
    
    func designUIElements() {
        designTableView()
    }
    
    func designTableView() {
        factTableView = UITableView.init(frame: view.frame, style: .plain)
        factTableView.dataSource = self
        factTableView.delegate = self
        factTableView.translatesAutoresizingMaskIntoConstraints = true
        factTableView.tableFooterView = UIView()
        factTableView.allowsSelection = false
        view.addSubview(factTableView)
        
        factTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        factTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        factTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        factTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        factTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
    }
    
    func fetchDataFromServer() {
        factData = nil
        guard Connectivity.isConnectedToInternet() else {
            presentAlertWithTitle(title: "Alert", message: "Please check your Internet connection.")
            updateUI()
            return
        }
        
        FactService.fetchFactData { [weak self](success, fact) in
            guard success, let fact = fact  else {
                self?.presentAlertWithTitle(title: "Alert", message: "Error while fetching data.")
                self?.updateUI()
                return
            }
            self?.factData = fact
            self?.updateUI()
        }
    }
    
    func updateUI() {
        
        title = factData?.title
        factTableView.reloadData()
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factData?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let cellData: Row? = factData?.rows[indexPath.row]
        tableViewCell.textLabel?.text = cellData?.title
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

