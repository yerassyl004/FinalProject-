//
//  ApiManager.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.12.2023.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    static let urlStringSearch = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&q="
    
    private init() {}
    
    let apiKey9 = "c80c956d589c4b3d8b160941cef237d3"
    let apiKey6 = "30011e306ec3482ba4c36b90dbb87194"
    let apiKey4 = "9e70313646a84a7582b392dcc11c9b9b"
    let apiKey3 = "3780f2a1d0254918a4a50e9b4dd4e52b"
    let apiKey5 = "407853842ebf4a729ca6b7a5ad8e7208"
    let apiKey7 = "a8308d7db8824a43a11be5858e28e2e3"
    let apiKey2 = "2febb110cc9e4cab9edc20feb056bec4"
    var sport = "sport"
    var medicine = "medicine"
    var education = "education"
    var economocs = "economics"
    var science = "science"
    var business = "business&tech"
    var markets = "markets"
    var edu = "education&scince"
    var books = "books&arts"
    var life = "life&work"
    var style = "style"
    var journal = "journal&report"
    var category = "news"
    var language = "us"
    var data = "2023-12-15"
    var page = 1
    var currentData = "2023-12-22"
    
    //    Countries
    
    let india = "in"
    let US = "us"
    let UK = "gb"
    let canada = "ca"
    let germany = "ge"
    let china = "cn"
    let autralia = "au"
    let japan = "jp"
    
    
    func dateOneWeekAgo() -> String {
        let currentDate = Date()
        
        // Use the Calendar class to go back one week from the current date
        if let oneWeekAgo = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate) {
            // Use DateFormatter to format the date as "YYYY-MM-DD"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            // Convert the date to the desired format
            let formattedDate = dateFormatter.string(from: oneWeekAgo)
            
            return formattedDate
        } else {
            // Return an empty string or handle the error as needed
            return ""
        }
    }
        
        
        func fetchNews(completion: @escaping (Result<APINews, Error>) -> Void) {
            // Replace "YOUR_API_KEY" with your actual News API key
            
            //        https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&language=ru
            let urlString = "https://newsapi.org/v2/everything?q=\(category)&from=\(data)&sortBy=popularity&apiKey=\(apiKey2)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        func fetchNewsMain(completion: @escaping (Result<APINews, Error>) -> Void) {
            // Replace "YOUR_API_KEY" with your actual News API key
            
            //        https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&language=ru
            let urlString = "https://newsapi.org/v2/everything?q=news&from=2023-12-21&apiKey=\(apiKey2)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        func fetchNewsThisWeek(completion: @escaping (Result<APINews, Error>) -> Void) {
            // Replace "YOUR_API_KEY" with your actual News API key
            
            //        https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&language=ru
            let urlString = "https://newsapi.org/v2/everything?q=news&from=2023-12-13&sortBy=popularity&apiKey=\(apiKey2)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        func fetchNewsHedlines(completion: @escaping (Result<APINews, Error>) -> Void) {
            // Replace "YOUR_API_KEY" with your actual News API key
            
            //        https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&language=ru
            //        https://newsapi.org/v2/top-headlines?country=us&apiKey=a8308d7db8824a43a11be5858e28e2e3
            let urlString = "https://newsapi.org/v2/everything?q=news&from=2023-12-21&sortBy=popularity&apiKey=\(apiKey2)"
            
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        func fetchNewsSearch(with query: String, completion: @escaping (Result<APINews, Error>) -> Void) {
            // Replace "YOUR_API_KEY" with your actual News API key
            
            //        https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=407853842ebf4a729ca6b7a5ad8e7208&language=ru
            //        https://newsapi.org/v2/top-headlines?country=us&apiKey=a8308d7db8824a43a11be5858e28e2e3
            
            let searchUrl = ApiManager.urlStringSearch + query
            
            guard let url = URL(string: searchUrl) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        //    func fetchNews(completion: @escaping (Result<APINews, Error>) -> Void) {
        //        // Replace "YOUR_API_KEY" with your actual News API key
        //
        //        let urlString = "https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=\(apiKey)"
        //
        //        guard let url = URL(string: urlString) else {
        //            completion(.failure(NetworkError.invalidURL))
        //            return
        //        }
        //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //            if let error = error {
        //                completion(.failure(error))
        //                return
        //            }
        //
        //            guard let data = data else {
        //                completion(.failure(NetworkError.noData))
        //                return
        //            }
        //
        //            do {
        //                let decoder = JSONDecoder()
        //                decoder.dateDecodingStrategy = .iso8601
        //
        //                let newsData = try decoder.decode(APINews.self, from: data)
        //                completion(.success(newsData))
        //            } catch {
        //                completion(.failure(error))
        //            }
        //        }
        //
        //        task.resume()
        //    }
        
        //    MARK: Category
        
        //["Today", "Business & Tech", "Education & Scince", "Markets", "Books & Arts", "Life & Work", "Style", "Sport", "Journal Report", "Most popular"]
        
        func fetchNewsOnSport(completion: @escaping (Result<APINews, Error>) -> Void) {
            
            let urlString = "https://newsapi.org/v2/everything?q=\(sport)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnBusiness(completion: @escaping (Result<APINews, Error>) -> Void) {
            
            let urlString = "https://newsapi.org/v2/everything?q=\(business)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnMarkets(completion: @escaping (Result<APINews, Error>) -> Void) {
            
            let urlString = "https://newsapi.org/v2/everything?q=\(markets)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        
        
        func fetchNewsOnScince(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(edu)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnBooks(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(books)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnLife(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(life)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnStyle(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(style)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnJournal(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(journal)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnMostPopular(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/top-headlines?q=news&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        //    MARK: Country DATA
        
        func fetchNewsOnChina(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(china)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnAU(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(autralia)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnUK(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(UK)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnUS(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(US)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnCA(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(canada)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnGE(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(germany)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
        func fetchNewsOnJA(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(japan)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        func fetchNewsOnIN(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(india)&from=\(dateOneWeekAgo())&sortBy=popularity&apiKey=\(apiKey2)&language=en"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    class ApiManagerUS {
        static let shared = ApiManagerUS()
        
        private init() {}
        
        let apiKey = "3780f2a1d0254918a4a50e9b4dd4e52b"
        let apiKey2 = "407853842ebf4a729ca6b7a5ad8e7208"
        let sport = "sport"
        let medicine = "medicine"
        let education = "education"
        let economocs = "economics"
        let science = "science"
        let food = "food"
        
        //    Countries
        
        let india = "in"
        let US = "us"
        let UK = "gb"
        let canada = "ca"
        let germany = "ge"
        let china = "cn"
        let autralia = "au"
        let japan = "jp"
        
        func fetchNewsOnUS(completion: @escaping (Result<APINews, Error>) -> Void) {
            let urlString = "https://newsapi.org/v2/everything?q=\(US)&from=2023-12-15&sortBy=popularity&apiKey=\(apiKey2)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let newsData = try decoder.decode(APINews.self, from: data)
                    completion(.success(newsData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }




enum NetworkError: Error {
    case invalidURL
    case noData
}

//class ApiManager {
//    static let shared = ApiManager()
//    
//    private init() {}
//    
//    let apiKey = "a8308d7db8824a43a11be5858e28e2e3"
//    
//    var currentDate = Date()
//    
//    init(currentDate: Date = Date()) {
//        self.currentDate = currentDate
//    }
//    
//    func todaysDate(currentDate: Date) -> DateFormatter {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        _ = dateFormatter.string(from: currentDate)
//        return dateFormatter
//    }
//    let urlNews =  "https://newsapi.org/v2/everything?q=news&from=2023-12-15&sortBy=popularity&apiKey=a8308d7db8824a43a11be5858e28e2e3"
//    let urlString = "https://newsapi.org/v2/everything?"
//    let about = "q=news"
//    let date = "from=2023-12-15"
//    
//    func getNews(completion: @escaping(Result<APINews, Error>) -> Void) {
//        let url = URL(string: urlNews)!
//        _ = URLRequest(url: url)
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                
//                let newsData = try decoder.decode(APINews.self, from: data)
//                completion(.success(newsData))
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//}
//
