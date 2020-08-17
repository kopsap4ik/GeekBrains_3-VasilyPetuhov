//
//  VKService.swift
//  Client VK
//
//  Created by Василий Петухов on 14.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation

final class VKService {
    
    enum Method {
        case friends
        case photos (ownerID: String)
        case groups
        case searchGroup (searchText: String)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return "/method/photos.getAll"
            case .photos:
                return "/method/groups.get"
            case .searchGroup:
                return "/method/groups.search"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return [
                    //"user_id" : String(Session.instance.userId),
                    "fields": "photo_50",
                    //"access_token" : Session.instance.token
                ]
            case .groups:
                return [
                    //"user_id" : String(Session.instance.userId),
                    "extended": "1",
                    //"access_token" : Session.instance.token
                ]
            case let .photos(ownerID):
                return [
                    "owner_id": ownerID,
                    //"access_token" : Session.instance.token
                ]
            case let .searchGroup(searchText):
                return [
                    "q": searchText,
                    "type": "group",
                    //"access_token" : Session.instance.token
                ]
            }
        }
    }
    
    
    func loadData(_ method: Method, complition: @escaping () -> Void ) {
                
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = method.path
        
        let basicQueryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
        let additionalQueryItems = method.parameters.map{ URLQueryItem(name: $0, value: $1) } //преобразуем словарь в нужный формат
        urlConstructor.queryItems = basicQueryItems + additionalQueryItems
        
        guard let url = urlConstructor.url else {  //проверка, что получился url
            complition()
            return
        }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
            //print("Запрос к API: \(url)")
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(data ?? "пусто")
            complition()
        }
        task.resume()
    }
    
    
}
