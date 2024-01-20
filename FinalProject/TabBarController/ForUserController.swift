//
//  UserRecomendationController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit

class ForUserController: UIViewController {
    
    struct ArticleCountry {
        let source: Sources
        let author: String?
        let title: String
        let description: String?
        let url: String
        let urlToImage: String?
        let publishedAt: Date
        let content: String
        
    }
    
    struct Sources {
        let id: String?
        let name: String
    }
    
    
    var aritcle: [ArticleCountry] = []
    
    var newsData: [Articles] = []
    var newsDataUS: [ArticleCountry] = []
    var newsDataUK: [ArticleCountry] = []
    var newsDataAU: [ArticleCountry] = []
    var newsDataGE: [ArticleCountry] = []
    var newsDataCA: [ArticleCountry] = []
    var newsDataJA: [ArticleCountry] = []
    var newsDataCN: [ArticleCountry] = []
    var newsDataIN: [ArticleCountry] = []
    
    var sections: [String: [ArticleCountry]] = [:]
    var section: [ArticleCountry] = []
    
    var source: [Source] = []
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .systemGray6
        table.layer.cornerRadius = 10
        table.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
//    MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
//        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Explore"
        fetchNews()
        fetchNewsUS()
        setupConstraints()
        //        organizeDataIntoSectionsUS()
        organizeDataIntoSectionsUK()
        organizeDataIntoSectionsAU()
        organizeDataIntoSections()
        
//        let firstFiveArticles: [ArticleCountry] = Array(newsDataUK.prefix(5))
//        
//        DispatchQueue.main.async { [self] in
//            
//            for article in firstFiveArticles {
//                newsDataUK.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
//            }
//        }
    }
    
    func secondElements() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataUK.prefix(5))
        for article in firstFiveArticles {
            newsDataUK.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    
    func dataUK() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataUK.prefix(5))
        for article in firstFiveArticles {
            newsDataUK.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    
    func dataCA() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataCA.prefix(5))
        for article in firstFiveArticles {
            newsDataCA.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    func dataUS() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataUS.prefix(5))
        for article in firstFiveArticles {
            newsDataUS.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    func dataGE() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataGE.prefix(5))
        for article in firstFiveArticles {
            newsDataGE.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    func dataCN() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataCN.prefix(5))
        for article in firstFiveArticles {
            newsDataCN.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    func dataJA() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataJA.prefix(5))
        for article in firstFiveArticles {
            newsDataJA.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    func dataIN() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataIN.prefix(5))
        for article in firstFiveArticles {
            newsDataIN.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    
    func dataAU() -> [ArticleCountry]{
        let firstFiveArticles: [ArticleCountry] = Array(newsDataAU.prefix(5))
        for article in firstFiveArticles {
            newsDataAU.append(ArticleCountry(source: Sources(id: article.source.id, name: article.source.name), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content))
        }
        return firstFiveArticles
    }
    
    
    
    func setupConstraints() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        view.addSubview(activityIndicator)
        
        activityIndicator.center = view.center
    }
    
    //    MARK: Fetch DATA
    
    func fetchNews() {
        activityIndicator.startAnimating()
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
    func fetchNewsUS() {
        activityIndicator.startAnimating()
        ApiManager.shared.fetchNewsOnUS { [self] result in
            switch result {
            case .success(let newsData):
                
                self.newsDataUS = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.organizeDataIntoSectionsUS()
                }
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnIN { [self] result in
            
            switch result {
            case .success(let newsData):
                
                self.newsDataIN = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.organizeDataIntoSectionsIN()
                }
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnJA { [self] result in
            
            switch result {
            case .success(let newsData):
                
                self.newsDataJA = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.organizeDataIntoSectionsJA()
                }
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnGE { result in
            switch result {
            case .success(let newsData):
                
                self.newsDataGE = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    self.organizeDataIntoSectionsGE()
                }
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnUK { [self] result in
            
            switch result {
            case .success(let newsData):
                
                self.newsDataUK = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.organizeDataIntoSectionsUK()
                }
                
                //                self.sources = newsData.articles.map { $0.source }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnAU { result in
            switch result {
            case .success(let newsData):
                self.newsDataAU = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    self.organizeDataIntoSectionsAU()
                }
                
                //                self.sources = newsData.articles.map { $0.source }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnCA { result in
            switch result {
            case .success(let newsData):
                self.newsDataCA = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.organizeDataIntoSectionsCA()
                
                //                self.sources = newsData.articles.map { $0.source }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        ApiManager.shared.fetchNewsOnChina { result in
            switch result {
            case .success(let newsData):
                self.newsDataCN = newsData.articles.map {ArticleCountry(source: Sources(id: $0.source.id, name: $0.source.name), author: $0.author, title: $0.title, description: $0.description, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.organizeDataIntoSectionsCN()
                
                //                self.sources = newsData.articles.map { $0.source }
                
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    //    func organizeDataIntoSectionsUS() {
    //        sections.removeAll()
    //        for article in newsDataUS {
    //            if var sec = sections[article.title] {
    //                sec.append(article)
    //                sections[article.title] = aritcle
    //            } else {
    //                sections[article.title] = [article]
    //            }
    //        }
    //    }
    func organizeDataIntoSectionsUK() {
        sections.removeAll()
        for article in newsDataUK {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            // Reload table view after organizing data into sections
            self.tableView.reloadData()
        }
    }
    func organizeDataIntoSectionsAU() {
        sections.removeAll()
        for article in newsDataAU {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func organizeDataIntoSectionsCN() {
        sections.removeAll()
        for article in newsDataCN {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSectionsUS() {
        sections.removeAll()
        for article in newsDataUS {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSectionsCA() {
        sections.removeAll()
        for article in newsDataCA {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSectionsJA() {
        sections.removeAll()
        for article in newsDataJA {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSectionsIN() {
        sections.removeAll()
        for article in newsDataIN {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSectionsGE() {
        sections.removeAll()
        for article in newsDataGE {
            if var sec = sections[article.title] {
                sec.append(article)
                sections[article.title] = sec
            } else {
                sections[article.title] = [article]
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func organizeDataIntoSections() {
        sections.removeAll()
        
        sections["AU"] = newsDataAU
        
        sections["UK"] = newsDataUK
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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

extension ForUserController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataUK().count
        case 1:
            return dataUS().count
        case 2:
            return dataGE().count
        case 3:
            return dataCN().count
        case 4:
            return dataJA().count
        case 5:
            return dataAU().count
        case 6:
            return dataCA().count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "United Kingdom"
        case 1:
            return "United States"
        case 2:
            return "Germany"
        case 3:
            return "China"
        case 4:
            return "Japan"
        case 5:
            return "Australia"
        case 6:
            return "Canada"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        
        switch indexPath.section {
        case 0:
            let data = dataUK()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 1:
            let data = dataUS()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 2:
            let data = dataGE()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 3:
            let data = dataCN()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 4:
            let data = dataJA()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 5:
            let data = dataAU()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        case 6:
            let data = dataCA()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            cell.titleLabel.text = data.title
            cell.urlImage.kf.setImage(with: url)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .black // Set your desired text color
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Georgia-Bold", size: 24)
        titleLabel.layer.shadowColor = UIColor.gray.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        titleLabel.layer.shadowOpacity = 0.5
        titleLabel.layer.shadowRadius = 2
        
        headerView.addSubview(titleLabel)
        
        // Set constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var articleToAdd: Article?
        
        switch indexPath.section {
        case 0:
            let data = dataUK()[indexPath.row]
            
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
            
            
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
    //        delegate?.sendDataToDestination(data: "DATA SENDED \(data.url)")
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        case 1:
            let data = dataUS()[indexPath.row]
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
            
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
    //        delegate?.sendDataToDestination(data: "DATA SENDED \(data.url)")
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
            
        case 2:
            let data = dataGE()[indexPath.row]
            articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
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
            
    //        delegate?.sendDataToDestination(data: "DATA SENDED \(data.url)")
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        case 3:
            let data = dataCN()[indexPath.row]
            let url = URL(string: data.urlToImage ?? "")
            
            articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
            
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
            
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        case 4:
            let data = dataJA()[indexPath.row]
            articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
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
            
    //        delegate?.sendDataToDestination(data: "DATA SENDED \(data.url)")
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        case 5:
            let data = dataAU()[indexPath.row]
            articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
            let vc = WebViewController()
            print("History shared \(History.shared.history)")
            
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
            
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        case 6:
            let data = dataCA()[indexPath.row]
            
            articleToAdd = Article(source: SourcesHistory(id: data.source.id, name: data.source.name), author: data.author, title: data.title, description: data.description, url: data.url, urlToImage: data.urlToImage, publishedAt: data.publishedAt, content: data.content)
                
                print("History shared \(History.shared.history)")
            
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
            
            let vc = WebViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.webURL = "\(String(describing: data.url))"
            
        default:
            break
        }
        
    }
    
    
}
    
