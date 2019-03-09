//
//  ViewController.swift
//  WiproAssignment
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var factTableView: UITableView?
    var factCollectionView: UICollectionView?
    var factData: Fact?
    
    private let kCellIdentifer = "CellIdentifier"
    private let kNoInternet = "Please check your Internet connection."
    private let kAlertTitle = "Alert"
    private let kErrorMessage = "Error while fetching data."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        designUIElements()
        fetchDataFromServer()
    }
}

private extension ViewController {
    
    func designUIElements() {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            designCollectionView()
        } else {
            designTableView()
        }
    }
    
    func designTableView() {
        factTableView = UITableView()
        factTableView?.translatesAutoresizingMaskIntoConstraints = false
        factTableView?.dataSource = self
        factTableView?.delegate = self
        factTableView?.tableFooterView = UIView()
        factTableView?.allowsSelection = false
        factTableView?.estimatedRowHeight = 500
        factTableView?.register(RowTableviewCell.self, forCellReuseIdentifier: kCellIdentifer)
        view.addSubview(factTableView!)
        
        factTableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        factTableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        factTableView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        factTableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func designCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        
        factCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        factCollectionView?.dataSource = self
        factCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        factCollectionView?.backgroundColor = UIColor.white
        factCollectionView?.register(RowCollectionView.self, forCellWithReuseIdentifier: kCellIdentifer)
        view.addSubview(factCollectionView!)
        
        factCollectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        factCollectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        factCollectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        factCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func fetchDataFromServer() {
        factData = nil
        guard Connectivity.isConnectedToInternet() else {
            presentAlertWithTitle(title: kAlertTitle, message: kNoInternet)
            updateUI()
            return
        }
        
        FactService.fetchFactData { [weak self](success, fact) in
            guard success, let fact = fact  else {
                self?.presentAlertWithTitle(title: self?.kAlertTitle ?? "", message: self?.kErrorMessage ?? "")
                self?.updateUI()
                return
            }
            self?.factData = fact
            self?.updateUI()
        }
    }
    
    func updateUI() {
        title = factData?.title
        factTableView?.reloadData()
        factCollectionView?.reloadData()
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factData?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifer, for: indexPath) as! RowTableviewCell
        let cellData: Row? = factData?.rows[indexPath.row]
        tableViewCell.row = cellData
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return factData?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifer, for: indexPath) as! RowCollectionView
        let cellData: Row? = factData?.rows[indexPath.row]
        collectionviewCell.row = cellData
        return collectionviewCell
    }
}

