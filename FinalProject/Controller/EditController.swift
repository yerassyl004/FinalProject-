//
//  EditController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 20.12.2023.
//

import UIKit

class EditController: UIViewController {
    
    let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Main Button", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    var additionalButtonsContainer: UIView!
    var centerYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Main Button
        view.addSubview(mainButton)
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
        
        // Additional Buttons Container (UIView)
        additionalButtonsContainer = UIView()
        additionalButtonsContainer.backgroundColor = .lightGray
        additionalButtonsContainer.isHidden = true
        
        // Additional Buttons
        let button1 = UIButton(type: .system)
        button1.setTitle("Button 1", for: .normal)
        
        let button2 = UIButton(type: .system)
        button2.setTitle("Button 2", for: .normal)
        
        let button3 = UIButton(type: .system)
        button3.setTitle("Button 3", for: .normal)
        
        // Add additional buttons to the container
        additionalButtonsContainer.addSubview(button1)
        additionalButtonsContainer.addSubview(button2)
        additionalButtonsContainer.addSubview(button3)
        
        // Add the main button and additional buttons container to the view
        
        view.addSubview(additionalButtonsContainer)
        
        // Set constraints for the main button
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainButton.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            mainButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Set constraints for the additional buttons container
        additionalButtonsContainer.translatesAutoresizingMaskIntoConstraints = false
//        centerYConstraint = additionalButtonsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([
            additionalButtonsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additionalButtonsContainer.topAnchor.constraint(equalTo: mainButton.bottomAnchor),
            
        ])
        
        // Set constraints for additional buttons within the container
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: additionalButtonsContainer.topAnchor, constant: 8),
            button1.centerXAnchor.constraint(equalTo: additionalButtonsContainer.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
            button2.centerXAnchor.constraint(equalTo: additionalButtonsContainer.centerXAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 8),
            button3.centerXAnchor.constraint(equalTo: additionalButtonsContainer.centerXAnchor)
        ])
    }
    
    @objc func mainButtonClicked() {
        // Toggle visibility of additional buttons with animation
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseInOut,
                       animations: {
            self.additionalButtonsContainer.isHidden.toggle()
            self.centerYConstraint.isActive.toggle()
            self.view.layoutIfNeeded()
        },
                       completion: nil)
    }
}
