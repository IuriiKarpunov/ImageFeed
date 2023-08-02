//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Iurii on 02.08.23.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var webView: WKWebView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/authorize")!
        urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: accessKey),
        URLQueryItem(name: "redirect_uri", value: redirectURI),
        URLQueryItem(name: "response_type", value: "code"),
        URLQueryItem(name: "scope", value: accessScope)
        ]
        let url = urlComponents.url!
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - IBAction
    
    @IBAction func didTapBackButton(_ sender: Any) {
        
    }
}
