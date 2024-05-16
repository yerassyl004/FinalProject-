//
//  MainNewsViewModel.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.05.2024.
//

import UIKit

final class MainNewsViewModel {
    
    var newsTableData = [NewsDesk]()
    weak var navigationController: UINavigationController?
    
    func cellNewsTable(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
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
    
    func fetchNewsTableView() {
        ApiManager.shared.fetchNewsMain { result in
            switch result {
            case .success(let newsData):
                for data in newsData.articles {
                    if let imageString = data.urlToImage, let url = URL(string: imageString) {
                        let model = NewsDesk(url: url,
                                                      title: data.title,
                                                      content: data.content)
                        self.newsTableData.append(model)
                    }
                }
            case .failure(let error):
                print("Error fetching news data: \(error)")
            }
        }
    }
}
