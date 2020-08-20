//
//  SearchGroup.swift
//  Client VK
//
//  Created by Василий Петухов on 05.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation

//struct SearchGroupResponse: Decodable {
//    var response: Response
//
//    struct Response: Decodable {
//        var count: Int
//        var items: [Item]
//
//        struct Item: Decodable {
//            var name: String
//            var logo: String  // уже тут нужно писать желаемые названия
//
//            // enum и init нужны если нужно иметь другие названия переменных в отличии от даннных в json
//            // например: logo = "photo_50" (я хочу: logo, а в jsone это: photo_50 )
//            // но все равно нужно указать другие значения, например: name (без уточнения)
//            enum CodingKeys: String, CodingKey {
//                case name
//                case logo = "photo_50"
//            }
//
//            init(from decoder: Decoder) throws {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//                name = try container.decode(String.self, forKey: .name)
//                logo = try container.decode(String.self, forKey: .logo)
//            }
//        }
//    }
//}

class SearchGroup {
    
    //данные для авторизации в ВК
    func loadData(searchText:String, complition: @escaping ([Group]) -> Void ) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }

            do {
                let arrayGroups = try JSONDecoder().decode(GroupsResponse.self, from: data)
                var searchGroup: [Group] = []
                
                for i in 0...arrayGroups.response.items.count-1 {
                    let name = ((arrayGroups.response.items[i].name))
                    let logo = arrayGroups.response.items[i].logo
                    let id = arrayGroups.response.items[i].id
                    searchGroup.append(Group.init(groupName: name, groupLogo: logo, id: id))
                }
                
                complition(searchGroup)
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()
        
    }
    
}
