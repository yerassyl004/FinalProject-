//
//  customNewsView.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit

class customNewsView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Allow multiple lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Allow multiple lines
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
        addSubview(imageView)
        addSubview(label)
        
        // Set constraints for imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // Set constraints for label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        
    }
    
    // Set the image for the imageView
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    // Set the text for the label
    func setText(_ text: String) {
        label.text = text
    }
    
    override var intrinsicContentSize: CGSize {
        let imageSize = imageView.intrinsicContentSize
        let labelSize = label.intrinsicContentSize
        
        let totalHeight = imageSize.height + labelSize.height + 8  // Add spacing between image and label
        
        return CGSize(width: UIView.noIntrinsicMetric, height: totalHeight)
    }
    
    
    
}
