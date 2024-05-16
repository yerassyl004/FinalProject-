//
//  VideoNewsController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit
import FirebaseAuth

class VideoNewsController: UIViewController {
    
    var historyArray: [String] = []
    var str = ""
    
    

    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    var historyData: [Article] = History.shared.history
    
    //    MARK: Properies
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
//        view.backgroundColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
//        view.backgroundColor = .systemTeal
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.frame = CGRect(x: 0, y: 200, width: 393, height: 852)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let testView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 400)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
        NotificationCenter.default.addObserver(self, selector: #selector(historyDidChange), name: NSNotification.Name(rawValue: "HistoryDidChangeNotification"), object: nil)
           
        view.backgroundColor = .systemGray6
        let vc = ExploreController()
        vc.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        setupUI()
        setup()
        
        let viewHeight: CGFloat = CGFloat(History.shared.history.count)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        loadHistoryFromFile()
        saveHistoryToFile()
        setupScrollView()
    }
    
    @objc func historyDidChange() {
        updateHeight()
    }
    func updateHeight() {
        let newHeight = heightTable()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
//        NSLayoutConstraint.deactivate([
//            tableView.heightAnchor.constraint(equalToConstant: CGFloat(History.shared.history.count * 160)),
//        ])
        updateTableViewHeight()
        
        print("History Count is \(History.shared.history.count)")
        
        view.layoutIfNeeded()
        view.setNeedsLayout()
        saveHistoryToFile()
        loadHistoryFromFile()
//        print(History.shared.history.count * 140)
//        print("HISTORY DATA IS opjapojsaop\(History.shared.history)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        DispatchQueue.global(qos: .background).async {
            self.loadHistoryFromFile()
            self.heightTable()
            
            DispatchQueue.main.async {
                
//                var newFrame = self.contentView.frame
//                newFrame.size.height = CGFloat(History.shared.history.count)
//                self.contentView.frame = newFrame
//                
            }
        }
        
        
    }
    
    
//    MARK: Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
        
        tableView.reloadData()
        if !History.shared.history.isEmpty {
            let lastIndexPath = IndexPath(row: History.shared.history.count - 1, section: 0)
            tableView.scrollToRow(at: lastIndexPath, at: .top, animated: true)
        }
        heightTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Reload the data to update cell heights
        tableView.reloadData()
    }
    
    private func setupUI() {
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.label.text = "\(user.username)\n\(user.email)"
            }
        }
        
        
        
        
        ApiManager.shared.fetchNews { result in
            switch result {
            case .success(let newsData):
                
                for article in newsData.articles {
                    
                }
            case .failure(let error):
                // Handle error
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(contentView)
//        stackView.addArrangedSubview(tableView)
     
        configureContainerView()
        
    }
    
    func heightTable() {
        
        
    }
    
    var myViewHeightConstraint: NSLayoutConstraint!
    var height = History.shared.history.count
    private func configureContainerView() {
        
        
//        let totalHeight = CGFloat(tableView.numberOfRows(inSection: 0)) * tableView.rowHeight
//        myViewHeightConstraint.constant = totalHeight
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
//        
//        let viewHeight: CGFloat = CGFloat((History.shared.history.count * 160) + 90)
//        tableView.frame.size.height = viewHeight
        
//        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 0),
//        ])
        
        contentView.addSubview(label)
        contentView.addSubview(tableView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layoutIfNeeded()
        contentView.setNeedsUpdateConstraints()
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100),
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        tableViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
    }
    
    func updateTableViewHeight() {
        // Calculate the new height based on the number of rows
        height = History.shared.history.count
        let newHeight = CGFloat(height * 160 + 100)
        // Update the height constraint
        tableViewHeightConstraint?.constant = newHeight

        // Animate the change
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setup() {
        
        let settingsBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingBtnPressed))
        navigationItem.rightBarButtonItem = settingsBtn
        
    }
    
    @objc func settingBtnPressed() {
        let vc = SettingsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func formatTimeDifference(inputDate: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: inputDate, to: currentDate)

        
        if let days = components.day, days > 0 {
            if days == 1 {
                return "yesterday"
            } else {
                return "\(days) days ago"
            }
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) " + (hours == 1 ? "hour" : "hours") + " ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) " + (minutes == 1 ? "minute" : "minutes") + " ago"
        } else {
            return "just now"
        }
    }
    
    func saveHistoryToFile() {
        let fileManager = FileManager.default

        if let userIdentifier = Auth.auth().currentUser?.uid,
           let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let userDirectory = documentDirectory.appendingPathComponent(userIdentifier)

            do {
                try fileManager.createDirectory(at: userDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating user directory: \(error)")
                return
            }

            let fileURL = userDirectory.appendingPathComponent("historyData.json")

            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(History.shared.history)
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error saving history data: \(error)")
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveHistoryToFile()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadHistoryFromFile()
        return true
    }


    func loadHistoryFromFile() {
        let fileManager = FileManager.default

        if let userIdentifier = Auth.auth().currentUser?.uid,
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let userDirectory = documentDirectory.appendingPathComponent(userIdentifier)
            let fileURL = userDirectory.appendingPathComponent("historyData.json")

            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let historyArray = try decoder.decode([Article].self, from: data)

                History.shared.updateHistory(with: historyArray)
                print("Successfully loaded history data")
            } catch {
                print("Error loading history data: \(error)")
            }
        }
    }
}


extension VideoNewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.shared.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        
        let data = History.shared.history[indexPath.row]
        
        func subtractDate(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            var datePast = ""
            if let yourDate = dateFormatter.date(from: "2023-12-22 15:20:48 +0000") {
                let currentDate = Date()
                
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yourDate, to: currentDate)
                
                datePast = "\(String(describing: components.day))"
            } else {
                print("Error: Unable to parse the date string.")
            }
            
            return datePast
        }
        
        cell.titleLabel.text = data.title
        let url = URL(string: data.urlToImage ?? "")
        cell.urlImage.kf.setImage(with: url)
        cell.dateLabel.text = formatTimeDifference(inputDate: data.publishedAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = History.shared.history[indexPath.row]
        
        let vc = WebViewController()
        navigationController?.pushViewController(vc, animated: true)
//        vc.webURL = "\(String(describing: data.url))"
    }
}

extension VideoNewsController: DataTransferDelegate {
    func sendDataToDestination(data: String) {
        self.str = data
    }
    
    
}
