//
//  APIData.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import Foundation

struct APINews: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}
struct Articles: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}
struct Source: Codable {
    let id: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

extension APINews {
    public static func getNewsData() -> [APINews] {
        return [APINews(status: "ok", totalResults: 1000, articles: [Articles(source: Source(id: "asca", name: "cass"), author: "sdcsd", title: "csdc", description: "csds", url: "csd", urlToImage: "csd", publishedAt: Date(), content: "sxasx")])
        ]
    }
}
