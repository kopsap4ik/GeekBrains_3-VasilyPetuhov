//
//  GetFriendsList.swift
//  Client VK
//
//  Created by Василий Петухов on 03.08.2020.
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

class GetFriendsList {
    
    //данные для авторизации в ВК
    func loadData(complition: @escaping ([Friends]) -> Void ) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //            print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
            
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
