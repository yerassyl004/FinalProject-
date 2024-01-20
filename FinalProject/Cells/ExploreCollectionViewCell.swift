//
//  ExploreCollectionViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 18.12.2023.
//

import UIKit

//
//  CollectionViewCell.swift
//  EnglishProject
//
//  Created by Ерасыл Еркин on 11.12.2023.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(label)
        
        label.numberOfLines = 0 // Set to 0 for multiline
//        label.lineBreakMode = .wordWrap
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
}

