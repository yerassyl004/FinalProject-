//
//  SettingsController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import UIKit

class SettingsController: UIViewController {
    
//    MARK: Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    let logOutBitton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let themeBotton: UIButton = {
        let button = UIButton()
        button.setTitle("Dark Mode", for: .normal)
        button.backgroundColor = .systemGray6
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
        view.frame = CGRect(x: 0, y: 200, width: 393, height: 852)
        return view
    }()
    
    var settingArray: [String] = ["Account", "Theme", "Text Size", "Language", "About"]
    
    
    private let settingView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 10
        view.isHidden = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
//    MARK: Main View

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Settings"
        setupUI()
        setupTable()
    }
    
    func setupTable() {
        
        self.view.addSubview(logOutBitton)
        logOutBitton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        NSLayoutConstraint.activate([
            logOutBitton.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 15),
            logOutBitton.leftAnchor.constraint(equalTo: view.leftAnchor),
            logOutBitton.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc private func didTapTheme() {
        
    }
    
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
//    MARK: Functions
    
    private func setupUI() {
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.settingArray.insert("\(user.email)", at: 0)
                self.label.text = "\(user.username)\n\(user.email)"
            }
        }
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -100),
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        self.view.addSubview(settingView)
        NSLayoutConstraint.activate([
            settingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingView.heightAnchor.constraint(equalToConstant: 200),
            settingView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

extension SettingsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.text = settingArray[indexPath.row]
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.settingView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
