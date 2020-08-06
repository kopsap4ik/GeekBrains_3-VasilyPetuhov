//
//  RealmOperations.swift
//  Client VK
//
//  Created by Василий Петухов on 06.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmOperations {
    
    func saveFriendsToRealm(_ friendList: [Friend]) {
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(friendList)
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsToRealm(_ grougList: [Group]) {
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(grougList)
            }
        } catch {
            print(error)
        }
    }
    
}
