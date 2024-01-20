//
//  UserTableViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let urlImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(urlImage)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -120),
            titleLabel.heightAnchor.constraint(equalToConstant: 110),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
        ])
        
        NSLayoutConstraint.activate([
            urlImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            urlImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5),
            urlImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            urlImage.heightAnchor.constraint(equalToConstant: 105)
        
        ])
        
        
    }
}
