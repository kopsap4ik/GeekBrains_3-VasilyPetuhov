//
//  AuthenticationVK.swift
//  Client VK
//
//  Created by Василий Петухов on 28.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation


struct FriendsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Items]
        
        struct Items: Decodable {
            var id: Int
            var first_name: String
            var last_name: String
            var photo_50: String
        }
    }
}

class GetDataFromVK {
    
    enum parameterAPI {
        case namesAndAvatars
        case photos
        case groups
        case searchGroups
    }
    
    //данные для авторизации в ВК
    func loadData(_ parameter: parameterAPI, complition: @escaping ([Friends]) -> Void ) {
    
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.120")
        ]
        
        switch parameter { //изменяющиеся параметры конструктора в зависимости от запроса
        case .namesAndAvatars:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .photos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(Session.instance.userId)))
        case .groups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.instance.userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "video")) // нужно использовать поисковую фразу
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }
        
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //            print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
//            guard let json = try? JSONSerialization.jsonObject(with: data) else { return }
            //            print("Вывод json из ответа: \(String(describing: json))")
            
            //            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //            print(str) //печатает кирилицу нормально
            
            //            let array = json as! [String : [String:Any]]
            
            //            let array = json as! [String: [[String:Any]]]
            //            let users = array.map { FullResponse(json: $0) }
            
            
            do {
                let arrayFriends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                var fullNamesFriends: [Friends] = []
                    for i in 0...arrayFriends.response.items.count-1 {
                        let name = ((arrayFriends.response.items[i].first_name) + " " + (arrayFriends.response.items[i].last_name))
                        let avatar = arrayFriends.response.items[i].photo_50
                        let id = String(arrayFriends.response.items[i].id)
                        fullNamesFriends.append(Friends.init(userName: name, userAvatar: avatar, owner_id: id))
                   }
                complition(fullNamesFriends)
            } catch let error {
                print(error)
                complition([])
            }
            
        }
        task.resume()
        
    }
    
}
