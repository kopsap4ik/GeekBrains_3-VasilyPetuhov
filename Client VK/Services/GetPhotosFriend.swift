//
//  GetPhotosFriend.swift
//  Client VK
//
//  Created by Василий Петухов on 03.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation
import RealmSwift

struct PhotosResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var count: Int
        var items: [Item]
        
        struct Item: Decodable {
            //var album_id: Int
            //var date: Int
            //var id: Int
            var ownerID: Int
            //var has_tags: Bool
            var sizes: [Sizes]
            //var text: String
            
            private enum CodingKeys: String, CodingKey {
                case ownerID = "owner_id"
                case sizes
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                ownerID = try container.decode(Int.self, forKey: .ownerID)
                sizes = try container.decode([Sizes].self, forKey: .sizes)
            }
            
            struct Sizes: Decodable {
                //var height: Int
                var url: String
                //var type: String
                //var width: Int
            }
        }
    }
}


class GetPhotosFriend {
    
    //данные для авторизации в ВК
    func loadData(_ ownerID: String) {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.122")
        ]
              
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            //print("Запрос к API: \(urlConstructor.url!)")
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            guard let data = data else { return }
            
            do {
                let arrayPhotosFriend = try JSONDecoder().decode(PhotosResponse.self, from: data)
                var photosFriend: [Photo] = []
                var ownerID = ""

                for i in 0...arrayPhotosFriend.response.items.count-1 {
                    if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                        //ownerID = String(arrayPhotosFriend.response.items[i].owner_id)
                        ownerID = String(arrayPhotosFriend.response.items[i].ownerID)
                        photosFriend.append(Photo.init(photo: urlPhoto, ownerID: ownerID))
                    }
                }
                DispatchQueue.main.async {
                    RealmOperations().savePhotosToRealm(photosFriend, ownerID)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
}
