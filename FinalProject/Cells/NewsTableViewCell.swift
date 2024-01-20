//
//  NewsTableViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 17.12.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 20
        label.font = UIFont(name: "Georgia-Bold", size: 24)
        label.layer.shadowColor = UIColor.gray.cgColor
                label.layer.shadowOffset = CGSize(width: 1, height: 1)
                label.layer.shadowOpacity = 0.5
                label.layer.shadowRadius = 2
        label.numberOfLines = 4
//        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 6
//        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
//        image.backgroundColor = .yellow
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(contentLabel)
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        contentLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        contentLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            titleLabel.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            contentLabel.heightAnchor.constraint(equalToConstant: 120),
            
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

}
