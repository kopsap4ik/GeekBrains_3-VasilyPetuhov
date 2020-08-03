//
//  GetGroupsList.swift
//  Client VK
//
//  Created by Василий Петухов on 03.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation

struct GroupsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Items]
        
        struct Items: Decodable {
            var id: Int
            var name: String
            var screen_name: String
            var photo_50: String
        }
    }
}

class GetGroupsList {
    
    //данные для авторизации в ВК
    func loadData(complition: @escaping ([Groups]) -> Void ) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                        print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
            
            do {
                let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                var fullGroupList: [Groups] = []
                for i in 0...arrayGroups.response.items.count-1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let avatar = arrayGroups.response.items[i].photo_50
                    fullGroupList.append(Groups.init(groupName: name, groupLogo: avatar))
                }
                complition(fullGroupList)
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()
        
    }
    
}
