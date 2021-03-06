//
//  RowTableviewCell.swift
//  WiproAssignment
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import UIKit

class RowTableviewCell: UITableViewCell {
    
    var row: Row? {
        didSet {
            rowView.row = row
        }
    }
    
    let rowView: RowView = {
        let view = RowView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rowView)
        rowView.translatesAutoresizingMaskIntoConstraints = false
        rowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        rowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        rowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        rowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
