////
////  AuthenticationVK.swift
////  Client VK
////
////  Created by Василий Петухов on 28.07.2020.
////  Copyright © 2020 Vasily Petuhov. All rights reserved.
////
//
//import Foundation
//
//struct UserJson {
//    let id: Int
//    var name = ""
//    var username = ""
//    var email = ""
//    var address: Address?
//    var phone = ""
//    var website = ""
//    var company: Company?
//    
//    init(id: Int) {
//        self.id = id
//    }
//    
//    // вспомогательный init для парсинга json
//    init(json: [String: Any] ) {
//        let id = json["id"] as! Int
//        self.init(id: id)
//        
//        self.name = json["name"] as! String
//        self.username = json["username"] as! String
//        
//        self.email = json["email"] as! String
//        self.phone = json["phone"] as! String
//        self.website = json["website"] as! String
//        
//        let addressJson = json["address"] as! [String: Any]
//        self.address = Address(json: addressJson)
//        
//        let companyJson = json["company"] as! [String: Any]
//        self.company = Company(json: companyJson)
//    }
//}
//
//struct Address {
//    struct Geo {
//        var lat = ""
//        var lng = ""
//    }
//    
//    var street = ""
//    var suite = ""
//    var city = ""
//    var zipcode = ""
//    var geo: Geo?
//    
//    init(json: [String: Any] ) {
//        self.suite = json["suite"] as! String
//        self.city = json["city"] as! String
//        self.zipcode = json["zipcode"] as! String
//        let geoJson = json["geo"] as! [String: Any]
//        let lat = geoJson["lat"] as! String
//        let lng = geoJson["lng"] as! String
//        self.geo = Geo(lat: lat, lng: lng)
//    }
//}
//
//struct Company {
//    var name = ""
//    var catchPhrase = ""
//    var bs = ""
//    
//    init(json: [String: Any] ) {
//        self.name = json["name"] as! String
//        self.catchPhrase = json["catchPhrase"] as! String
//        self.bs = json["bs"] as! String
//    }
//}
//
//class TestLoadData {
//    
//    
//    //данные для авторизации в ВК
//    func loadData() {
//        
//        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            guard let data = data,
//                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
//                    return
//            }
//            
//            let array = json as! [[String: Any]]
//            let users = array.map { UserJson(json: $0) }
//            
////            for i in 0...users.count-1 {
////            print(users[i].name)
////            }
//            
//            
//        }.resume()
//        
//    }
//        
//}
