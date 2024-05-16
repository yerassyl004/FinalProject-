//
//  MainNewsViewModel.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.05.2024.
//

import UIKit

final class MainNewsViewModel {
    
    var newsTableData = [MainViewModel.NewsDesk]()
    var newsCollectionData = [MainViewModel.CollectionDesk]()
    weak var navigationController: UINavigationController?
    
    
    // MARK: - TableViewCell
    func cellNewsTable(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewsTableViewCell
        let data = newsTableData[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.configure(model: data)
        
        return cell
    }
    
    func didSelectedCell(tableView: UITableView, indexPath: IndexPath) {
        let data = newsTableData[indexPath.row]
        
        var articleToAdd: HistoryModel?
        let vc = WebViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.webURL = data.url
        articleToAdd = HistoryModel(title: data.content, url: data.url, date: Date())
    }
    
    // MARK: - CollectionViewCell
    func cellNewsCollection(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MainCollectionViewCell
        
        return cell
    }
    
    // MARK: - Fetch Data
    func fetchNewsTableView() {
        ApiManager.shared.fetchNewsMain { result in
            switch result {
            case .success(let newsData):
                for data in newsData.articles {
                    if let imageString = data.urlToImage, let imageUrl = URL(string: imageString), let url = URL(string: data.url) {
                        
                        let model = MainViewModel.NewsDesk(url: url,
                                             title: data.title,
                                             content: data.content,
                                             imageURL: imageUrl)
                        self.newsTableData.append(model)
                    }
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
    
    func fetchNewsHedlines() {
        ApiManager.shared.fetchNewsHedlines { result in
            switch result {
            case .success(let newsData):
                for data in newsData.articles {
                    if let imageString = data.urlToImage, let imageUrl = URL(string: imageString), let url = URL(string: data.url) {
                        
                        let model = MainViewModel.CollectionDesk(image: imageUrl,
                                                                 title: data.title,
                                                                 date: data.publishedAt,
                                                                 url: url)
                        self.newsCollectionData.append(model)
                    }
                }
                
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
}
