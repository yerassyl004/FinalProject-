//
//  HistoryData.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import Foundation

struct HistoryData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
struct Article: Codable {
    let source: SourcesHistory
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var publishedAt: Date
    let content: String
    
    
}
struct SourcesHistory: Codable {
    let id: String?
    let name: String
}

class History {
    static let shared = History()
    
    var history: [Article] = []
    
    func updateHistory(with newData: [Article]) {
            history = newData
        }
}
