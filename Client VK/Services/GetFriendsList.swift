//
//  GetFriendsList.swift
//  Client VK
//
//  Created by Василий Петухов on 03.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation
import RealmSwift

struct FriendsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            var id: Int
            var firstName: String
            var lastName: String
            var avatar: String
            var deactivated: String?
            
            // enum и init нужны если нужно иметь другие названия переменных в отличии от даннных в json
            // например: logo = "photo_50" (я хочу: logo, а в jsone это: photo_50 )
            // но все равно нужно указать другие значения, например: id (без уточнения)
            private enum CodingKeys: String, CodingKey {
                case id
                case firstName = "first_name"
                case lastName = "last_name"
                case avatar  = "photo_50"
                case deactivated
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                id = try container.decode(Int.self, forKey: .id)
                firstName = try container.decode(String.self, forKey: .firstName)
                lastName = try container.decode(String.self, forKey: .lastName)
                avatar = try container.decode(String.self, forKey: .avatar)
                
                // необязательный ключ (может отсутсвовать)
                deactivated = try? container.decodeIfPresent(String.self, forKey: .deactivated)
            }
        }
    }
}

class GetFriendsList {
    
    //данные для авторизации в ВК
    func loadData(complition: @escaping () -> Void ) {
        
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
            //print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
            
            do {
                let arrayFriends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                var friendList: [Friend] = []
                for i in 0...arrayFriends.response.items.count-1 {
                    // не отображаем удаленных и заблокированных друзей
                    if arrayFriends.response.items[i].deactivated == nil {
                        let name = ((arrayFriends.response.items[i].firstName) + " " + (arrayFriends.response.items[i].lastName))
                        let avatar = arrayFriends.response.items[i].avatar
                        let id = String(arrayFriends.response.items[i].id)
                        friendList.append(Friend.init(userName: name, userAvatar: avatar, ownerID: id))
                    }
                }
                
                DispatchQueue.main.async {
                    RealmOperations().saveFriendsToRealm(friendList)
                    complition()
                }
                
            } catch let error {
                print(error)
                complition()
            }
        }
        task.resume()
    }
    
    //    func saveFriendsToRealm(_ friendList: [Friend]) {
    //        do {
    //            let realm = try Realm()
    //            try realm.write{
    //                realm.add(friendList)
    //            }
    //        } catch {
    //            print(error)
    //        }
    //    }
    
    
}
