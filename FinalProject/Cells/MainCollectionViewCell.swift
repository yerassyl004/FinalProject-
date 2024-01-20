//
//  MainCollectionViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 4
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
//        image.backgroundColor = .systemGray4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 10
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
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            label.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
        ])
    }
}
