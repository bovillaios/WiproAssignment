//
//  RowCollectionView.swift
//  WiproAssignment
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import UIKit

class RowCollectionView: UICollectionViewCell {

    var row: Row? {
        
        didSet {
            
            rowView.row = row
        }
        
    }
    
    let rowView: RowView = {
        
        let view = RowView()
        return view
    }()
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        contentView.addSubview(rowView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        rowView.translatesAutoresizingMaskIntoConstraints = false
        
        rowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        rowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        rowView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        rowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let screenWidth = UIScreen.main.bounds.size.width / 2 - 25
        
        rowView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
