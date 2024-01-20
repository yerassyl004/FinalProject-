//
//  ExploreController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit
import CoreData

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

protocol DataTransferDelegate: AnyObject {
    func sendDataToDestination(data: String)
}

class ExploreController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate {
    
    let categories = ["Today", "Business & Tech", "Education & Scince", "Markets", "Books & Arts", "Life & Work", "Style", "Sport", "Journal Report", "Most popular"]
    
    let customView = UIView()
        let button1 = UIButton()
        let button2 = UIButton()
        let button3 = UIButton()
    
    var lastContentOffset: CGFloat = 0
    var isSearchBarHidden = false
    
    let searchVC = UISearchController(searchResultsController: nil)
    weak var delegate: DataTransferDelegate?
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var searchData: [Articles] = []
    
    let containerCollection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerTable: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var newsData: [Articles] = []
    var sortedData: [Articles] = []
    
    var historyData: [Article] = []
    
    //MARK: - Properties
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var isEditingDate = false
    let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 600, width: 393, height: 500)
        view.isHidden = true
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "cscsomdocjsm"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 352, width: 393, height: 500)
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ExploreTableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = 10
        table.backgroundColor = .systemBackground
        return table
    }()
    
//    MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.systemGray6
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        title = "Explore"
        fetchNews()
//        createSearchBar()
        setupScrollView()
        
        collectionView.reloadData()
    }
    
    func createSearchBar() {
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = true
        scrollView.delegate = self
        
        if isSearchBarHidden {
            searchVC.searchBar.isHidden = true
        } else {
            searchVC.searchBar.isHidden = false
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
        
        stackView.addArrangedSubview(containerCollection)
        stackView.addArrangedSubview(containerTable)
        
        containerCollection.addSubview(searchBar)
        containerCollection.addSubview(collectionView)
        containerTable.addSubview(tableView)
        
        configureContainerView()
    }
    
    private func configureContainerView() {
        
        NSLayoutConstraint.activate([
            containerCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            containerCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            containerCollection.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            containerTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            containerTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            containerTable.heightAnchor.constraint(equalToConstant: 150*100)
        ])
        
        setup()
    }
    
    func setup() {
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: containerCollection.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: containerCollection.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: containerCollection.trailingAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerCollection.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: containerCollection.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: containerCollection.bottomAnchor),
        ])
        
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
//        let buttonItem = UIBarButtonItem(image: UIImage(systemName: "fitness.timer"), style: .plain, target: self, action: #selector(showCustomView))
//        navigationItem.rightBarButtonItem = buttonItem
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerTable.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerTable.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerTable.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerTable.bottomAnchor),
        ])
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func animationView() {
        self.dateView.translatesAutoresizingMaskIntoConstraints = false
        if isEditingDate == false {
            
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [] ) {
                
                self.dateView.isHidden = false
                
                NSLayoutConstraint.activate([
                    self.dateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    self.dateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    self.dateView.widthAnchor.constraint(equalToConstant: 150),
                    self.dateView.heightAnchor.constraint(equalToConstant: 150),
                ])
                self.isEditingDate = true
                
            } completion: { (completion) in
                
            }
            
            UIView.animate(withDuration: 0.25) {
                
                
            }
        }
        else {
            self.dateView.isHidden = true
            
            self.isEditingDate = false
        }
    }
    
    func showDarkOverlay() {
        
        view.sendSubviewToBack(dateView)
        
    }
    func hideDarkOverlay() {
    }
    
    @objc func showCustomView() {
        UIView.animate(withDuration: 0.3) {
            self.customView.frame.origin.y = self.view.frame.height - 200
        }
    }

    @objc func buttonTapped(sender: UIButton) {
        print("Button tapped: \(sender.titleLabel?.text ?? "")")
    }
    
    @objc func dateBtnPressed() {
        //        animationView()
        let vc = EditController()
        present(vc, animated: true)
        
    }
    
    func fetchNews() {
        
        activityIndicator.startAnimating()
        
        ApiManager.shared.fetchNews { result in
            switch result {
            case .success(let newsData):
                
                self.newsData = newsData.articles
                
                
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        
        
        var finalText = text.replacingOccurrences(of: " ", with: "")
        finalText = finalText.lowercased()
        
        activityIndicator.startAnimating()
        
        ApiManager.shared.fetchNewsSearch(with: finalText) { result in
            switch result {
            case .success(let newsData):
                
                
                self.newsData = newsData.articles
                
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
                print("Search \(self.searchData)")
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ApiManager.shared.fetchNews { result in
            switch result {
            case .success(let newsData):
                self.newsData = newsData.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 && isSearchBarHidden {
            // Scrolling up at the top, show the search bar
            showSearchBar()
        } else if offsetY > 0 && !isSearchBarHidden {
            // Scrolling down or not at the top, hide the search bar
            hideSearchBar()
        }
    }
    
    func hideSearchBar() {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.frame.origin.y -= self.navigationController?.navigationBar.frame.size.height ?? 0
        }
        isSearchBarHidden = true
    }
    
    func showSearchBar() {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.frame.origin.y += self.navigationController?.navigationBar.frame.size.height ?? 0
        }
        isSearchBarHidden = false
    }
    
    func formatTimeDifference(inputDate: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
//        let components = calendar.dateComponents([.second, .minute, .hour, .day], from: inputDate, to: currentDate)
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
    
    func getCurrentDate() -> (date: Date, formattedString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return (currentDate, formattedDate)
    }
    
}

extension ExploreController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = newsData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreTableViewCell
        cell.backgroundColor = .systemBackground
        
        
        if let imageString = data.urlToImage {
            
            let url = URL(string: imageString)
            cell.newsImageView.kf.setImage(with: url)
            cell.titleLabel.text = data.title
            cell.countryLabel.text = formatTimeDifference(inputDate: data.publishedAt)
            
        }
        else {
            cell.titleLabel.text = data.title
            cell.newsImageView.image = UIImage(named: "image")
        }
        
        print("DATA DATA DATA DATA\(String(describing: data.author))")
        print(hoursSinceRelease(releaseDate: data.publishedAt))
        print(data.publishedAt)
        func hoursSinceRelease(releaseDate: Date) -> Int {
            let currentDate = Date()
            
            // Use the current calendar
            let calendar = Calendar.current
            
            // Calculate the difference between the current date and the release date
            if let difference = calendar.dateComponents([.hour], from: releaseDate, to: currentDate).hour {
                
                return difference
            } else {
                return 0
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = newsData[indexPath.row]
        
        var articleToAdd: Article?
        
        historyData.append(Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content))
        
        History.shared.history.append(Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content))
        let vc = WebViewController()
        print("History shared \(History.shared.history)")
        
        delegate?.sendDataToDestination(data: "DATA SENDED \(data.url)")
        navigationController?.pushViewController(vc, animated: true)
        vc.webURL = "\(String(describing: data.url))"
        
        articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
        
        if let article = articleToAdd?.url {
            
            let current = getCurrentDate()
            articleToAdd?.publishedAt = current.date
            if !History.shared.history.contains(where: {$0.url == article }) {
                History.shared.history.insert(articleToAdd!, at: 0)
            }
            
            else {
                let index = History.shared.history.firstIndex(where: { $0.url == article })
                History.shared.history.remove(at: index!)
                History.shared.history.insert(articleToAdd!, at: 0)
            }
        }
    }
}

extension ExploreController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExploreCollectionViewCell
        cell.label.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            ApiManager.shared.fetchNews { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        } else if indexPath.row == 1 {
            ApiManager.shared.fetchNewsOnBusiness { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else if indexPath.row == 2 {
            ApiManager.shared.category = "education&scince"
            ApiManager.shared.fetchNews { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
            }
            ApiManager.shared.category = "education&scince"
        }else if indexPath.row == 3 {
            ApiManager.shared.fetchNewsOnMarkets { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else if indexPath.row == 4 {
            ApiManager.shared.fetchNewsOnBooks { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else if indexPath.row == 5 {
            ApiManager.shared.fetchNewsOnLife { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else if indexPath.row == 6 {
            ApiManager.shared.fetchNewsOnStyle { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else if indexPath.row == 7 {
            ApiManager.shared.fetchNewsOnSport { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
            }
        }
        else if indexPath.row == 8 {
            ApiManager.shared.fetchNewsOnJournal { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
                
            }
        }
        else {
            ApiManager.shared.fetchNewsOnMostPopular { result in
                switch result {
                case .success(let newsData):
                    self.newsData = newsData.articles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching news data: \(error)")
                }
            }
        }
    }
}

extension ExploreController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categories[indexPath.item]
        
        // Assuming you have a function to calculate label size based on text
        let labelSize = calculateLabelSize(text: category, font: UIFont.systemFont(ofSize: 16)) // Adjust the font size
        
        // Add extra padding if needed
        let cellWidth = labelSize.width + 20 // Add extra space for padding
        let cellHeight = labelSize.height + 20 // Add extra space for padding
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    private func calculateLabelSize(text: String, font: UIFont) -> CGSize {
            let label = UILabel()
            label.text = text
            label.font = font
            label.sizeToFit()
            return label.frame.size
        }
}


