//
//  MainNewsModel.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.05.2024.
//

import UIKit

enum MainViewModel {
    
    struct NewsDesk {
        let url: URL
        let title: String
        let content: String
        let imageURL: URL
    }
    
    struct CollectionDesk {
        let image: URL
        let title: String
        let date: Date
        let url: URL
    }
}
