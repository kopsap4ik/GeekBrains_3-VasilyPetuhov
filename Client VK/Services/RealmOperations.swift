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
                let oldFriendList = realm.objects(Friend.self) // список существующих записей
                realm.delete(oldFriendList) // удалить старые данные
                realm.add(friendList) // записать новые данные
            }
        } catch {
            print(error)
        }
    }
        
    func saveGroupsToRealm(_ grougList: [Group]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldGroupList = realm.objects(Group.self)
                realm.delete(oldGroupList)
                realm.add(grougList)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllFromRealm() {
        do {
            let realm = try Realm()
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
}
