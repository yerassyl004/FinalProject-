//
//  WebViewController.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 17.12.2023.
//

import UIKit

import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, DataTransferDelegate {
    
    var data = ""
    
    func sendDataToDestination(data: String) {
        self.data = data
    }
    
    var webURL: URL?
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        print("WEB URL is \(String(data))")
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let url = webURL {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: - WKNavigationDelegate Methods
    
    // Implement WKNavigationDelegate methods as needed
    // For example, you might want to handle page loading events.
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Handle page load start
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Handle page load finish
    }
}
