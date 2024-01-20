//
//  ExploreTableViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 17.12.2023.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    let labelWithoutImage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
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
        contentView.addSubview(countryLabel)
        contentView.addSubview(labelWithoutImage)
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            labelWithoutImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelWithoutImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelWithoutImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelWithoutImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
        
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            newsImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            countryLabel.heightAnchor.constraint(equalToConstant: 20),
            countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
    }

}
