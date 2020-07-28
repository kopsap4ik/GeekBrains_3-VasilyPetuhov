//
//  AuthenticationVK.swift
//  Client VK
//
//  Created by Василий Петухов on 28.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

//import Foundation
//
//class AuthenticationVK {
//    
//    //данные для авторизации в ВК
//    func loadAuthVK() -> URLRequest? {
//        // конструктор для URL
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "oauth.vk.com"
//        urlConstructor.path = "/authorize"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "client_id", value: "7548358"),
//            URLQueryItem(name: "display", value: "mobile"),
//            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//            URLQueryItem(name: "scope", value: "friends,photos,groups"),
//            URLQueryItem(name: "response_type", value: "token"),
//            URLQueryItem(name: "v", value: "5.120")
//        ]
//        
//        guard let url = urlConstructor.url  else { return nil }
//        let request = URLRequest(url: url)
//        return request
//    }
//    
//}


