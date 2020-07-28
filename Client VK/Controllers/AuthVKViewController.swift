//
//  TestViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 24.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import WebKit

class AuthVKViewController: UIViewController {
    
    var session = Session.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Конфигурация по умолчанию
//        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
//        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        // устанавливаем схему
        urlConstructor.scheme = "https"
        // устанавливаем хост
        urlConstructor.host = "oauth.vk.com"
        // путь
        urlConstructor.path = "/authorize"
        // параметры для запроса
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "7548358"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.120")
        ]
        
        let request = URLRequest(url: urlConstructor.url!)
        
        webView.load(request)

        
    }
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    
}


extension AuthVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let token = params["access_token"], let userID = params["user_id"] else { return }
        
        session.token = token
        session.userId = Int(userID)!
//        print(session.token)
//        print(session.userId)
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "AuthVKSuccessful", sender: nil)
    }
}
