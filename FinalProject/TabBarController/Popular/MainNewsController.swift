//
//  ViewController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import UIKit
import FirebaseAuth
import Kingfisher

class MainNewsController: UIViewController, UIScrollViewDelegate {
    
    var newsDataNews: [Articles] = []
    
    var isLoadingData = false
    
    var newsCollectionData = [MainViewModel.CollectionDesk]()
    
    var newsMainData: [Articles] = []
    
    var tableViewHeight: CGFloat = 0
    
    var heigtTable = 0
    var newsTableData = [MainViewModel.NewsDesk]()
    // MARK: - Properties
    private let viewModel = MainNewsViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .systemBackground
        table.layer.cornerRadius = 10
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let table: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    let newsMainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    let mainImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let titleMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia-Bold", size: 24)
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 4
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .blue
        label.textAlignment = .left
        label.numberOfLines = 10
        label.sizeToFit()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        return view
    }()
    
    let testView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 400)
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 100, y: 500, width: 193, height: 193)
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    let count: Int = 0
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.frame = CGRect(x: 100, y: 300, width: 193, height: 50)
        return label
    }()
    
//    MARK: - MAIN VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        setupScrollView()
        setupConstraints()
        configureContainerView()
        
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
        
        ApiManager.shared.fetchNewsMain { result in
            switch result {
            case .success(let newsData):
                DispatchQueue.main.async {
                    self.countLabel.text = "Total Results: \(newsData.totalResults)"
                    if let firstArticle = newsData.articles.last {
                        
                        self.newsMainData.append(firstArticle)
                        if let url = URL(string: firstArticle.urlToImage ?? "") {
                            self.imageView.kf.setImage(with: url)
                            self.mainImageView.kf.setImage(with: url)
                        }
                        self.titleMainLabel.text = firstArticle.title
                        self.contentLabel.text = firstArticle.description
                    }
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
        
        if isLoadingData {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Setup Navigation
    private func setupNavigation() {
        self.navigationItem.title = "Popular"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    }
    
    // MARK: - Setup View
    private func setupViews() {
        view.backgroundColor = UIColor.systemGray6
        self.newsTableData = viewModel.newsTableData
        self.newsCollectionData = viewModel.newsCollectionData
        tableView.reloadData()
        viewModel.navigationController = self.navigationController
        view.addSubview(label)
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
        
        
        stackView.addArrangedSubview(testView)
        stackView.addArrangedSubview(contentView)
        stackView.addArrangedSubview(table)
        
        
        testView.addSubview(mainImageView)
        testView.addSubview(titleMainLabel)
        testView.addSubview(contentLabel)
        
        contentView.addSubview(collectionView)
        table.addSubview(tableView)
        configureContainerView()
        navigation()
    }
    
    func navigation() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(activityPressed))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        testView.isUserInteractionEnabled = true
        
        testView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func activityPressed() {
        let data = newsMainData
        var articleToAdd: Article?
        let vc = WebViewController()
        if let article = data.first {
            
            let current = getCurrentDate()
            articleToAdd?.publishedAt = current.date
//            if !History.shared.history.contains(where: {url == article }) {
//                History.shared.history.insert(articleToAdd!, at: 0)
//            }
            
//            else {
//                let index = History.shared.history.firstIndex(where: { $0.url == article })
//                History.shared.history.remove(at: index)
//                History.shared.history.insert(articleToAdd!, at: 0)
//            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureContainerView() {
        
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            testView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            testView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: testView.topAnchor),
            mainImageView.leftAnchor.constraint(equalTo: testView.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: testView.rightAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        
        NSLayoutConstraint.activate([
            titleMainLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor), // Add a spacing from newsMainView
            titleMainLabel.leftAnchor.constraint(equalTo: testView.leftAnchor, constant: 10),
            titleMainLabel.rightAnchor.constraint(equalTo: testView.rightAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleMainLabel.bottomAnchor), // Add a spacing from titleMainLabel
            contentLabel.leftAnchor.constraint(equalTo: testView.leftAnchor, constant: 10),
            contentLabel.rightAnchor.constraint(equalTo: testView.rightAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: testView.bottomAnchor),
        ])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Adjust the threshold as needed
        let threshold: CGFloat = 100.0
        
        // Check if the user has scrolled to the bottom of the scroll view
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.height
        
        if contentOffsetY > contentHeight - screenHeight - threshold && !isLoadingData {
            // User has scrolled to the bottom, trigger API call for more data
            
        }
        
        // Check if the user is scrolling up and close to the top
        if contentOffsetY < -threshold {
            // User is scrolling up, and close to the top, scroll to the top
            scrollView.setContentOffset(CGPoint(x: 0, y: -scrollView.contentInset.top), animated: true)
        }
    }
    
    func updateTable(hilght: CGFloat) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
//            NSLayoutConstraint.activate([
//                self.table.heightAnchor.constraint(equalToConstant: hilght),
//            ])
//            print(hilght)
//            self.view.layoutIfNeeded()
//        }
    }
    
    func setupConstraints() {
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.layer.cornerRadius = 10
        
        tableView.isScrollEnabled = false
        tableView.reloadData()
    
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentView.heightAnchor.constraint(equalToConstant: 510),
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        
        
        
        // Constraints for titleMainLabel
        
        
        // Constraints for contentLabel
        
        
//        adjustLabelHeight(label: titleMainLabel)
//        adjustLabelHeight(label: contentLabel)
         
        
        
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
//            table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            table.heightAnchor.constraint(equalToConstant: 600 * 60),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: table.topAnchor),
            tableView.leftAnchor.constraint(equalTo: table.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: table.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: table.bottomAnchor),
        ])
        view.layoutIfNeeded()
        
    }
    
    func adjustLabelHeight(label: UILabel) {
        let maxSize = CGSize(width: label.frame.size.width, height: CGFloat.infinity)
        let expectedSize = label.sizeThatFits(maxSize)
        
        // Update the height constraint of the label
        label.heightAnchor.constraint(equalToConstant: expectedSize.height).isActive = true
    }
    
    // MARK: - Selectors
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
    
    func calculateLabelHeight(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let labelSize = label.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude))
        return labelSize.height
    }
    
    func calculateImageHeight(_ image: UIImage) -> CGFloat {
        // Return the actual image height or a default height
        return image.size.height
    }
    
    func getCurrentDate() -> (date: Date, formattedString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return (currentDate, formattedDate)
    }
}

extension MainNewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellNewsTable(tableView: tableView, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 640
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectedCell(tableView: tableView, indexPath: indexPath)
    }
}

extension MainNewsController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.cellNewsCollection(collectionView: collectionView, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.5, left: 1, bottom: 1.5, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCollection(collectionView: collectionView, indexPath: indexPath)
    }
    
}

extension MainNewsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 250)
    }
}

