//
//  RowTableviewCell.swift
//  WiproAssignment
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class RowTableviewCell: UITableViewCell {
    
    var row: Row? {
        
        didSet {
            
            if let urlString = row?.imageHref, let url = URL(string: urlString) {
                
                let processor = DownsamplingImageProcessor(size: CGSize(width: 50, height: 50))
                rowImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeHolder.pdf"), options: [.processor(processor),.cacheOriginalImage]){ result in }
            } else {

                rowImageView.image = #imageLiteral(resourceName: "placeHolder.pdf")
            }
            titleLabel.text = row?.title
            descriptionLabel.text = row?.description
        }
        
    }
    
    let rowImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.alignment = .leading
        labelStackView.spacing = 2.5
        
        let mainStackView = UIStackView(arrangedSubviews: [rowImageView, labelStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.alignment = .center
        mainStackView.spacing = 10

        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        

    

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
