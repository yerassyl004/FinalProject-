//
//  MainCollectionViewCell.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    let dateFormatter = DateFormatter()
    
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
    
    func timeSinceRelease(from releaseDate: Date) -> String {
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.minute, .hour, .day], from: releaseDate, to: currentDate)
        
        if let days = components.day, days > 0 {
            return "\(days)d ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m ago"
        } else {
            return "just now"
        }
    }
    
    public func configure(model: MainViewModel.CollectionDesk) {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let releaseDate = dateFormatter.date(from: "2023-01-01 12:00:00") {
            let releasedTime = timeSinceRelease(from: releaseDate)
            dateLabel.text = releasedTime
        } else {
            print("Error parsing release date.")
        }
        
        label.text = model.title
        imageView.kf.setImage(with: model.image)
    }
}
