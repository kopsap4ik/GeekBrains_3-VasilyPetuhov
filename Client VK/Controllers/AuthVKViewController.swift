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
        webView.navigationDelegate = self
        //        removeCookie() //очистка куки, чтобы заново ввести логин и пароль
        loadAuthVK()
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    func loadAuthVK() {
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: "7548358"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.120")
        ]
        
        guard let url = urlConstructor.url  else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    // очистка куки, чтобы авторизоваться в ВК заново
    func removeCookie() {
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        
        cookieStore.getAllCookies {
            cookies in
            for cookie in cookies {
                cookieStore.delete(cookie)
            }
        }
    }
    
}

extension AuthVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // проверка на полученый адрес и получение данных из урла
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
        
        //DispatchQueue.main.async {
            
            if let token = params["access_token"], let userID = params["user_id"] {
                self.session.token = token
                self.session.userId = Int(userID)!
                
                decisionHandler(.cancel)
                
                // переход на контроллер с логином и вход в приложение при успешной авторизации
                self.performSegue(withIdentifier: "AuthVKSuccessful", sender: nil)
            } else {
                decisionHandler(.allow)
                // просто переход на контроллер с логином при неуспешной авторизации
                self.performSegue(withIdentifier: "AuthVKUnsuccessful", sender: nil)
            }
            
       // }
    }
}
