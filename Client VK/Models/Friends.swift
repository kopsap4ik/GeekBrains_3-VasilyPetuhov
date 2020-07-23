//
//  Friends.swift
//  Client VK
//
//  Created by Василий Петухов on 20.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//


import UIKit

struct User {
    let userName: String
    let userAvatar: UIImage?
    let userPhotos: [UIImage?]
}
//
//class FriendsList {
//    let friendsAll = [
//        User(userName: "Коля",
//             userAvatar: (UIImage(named: "person1")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3"), UIImage(named: "person4")]),
//        
//        User(userName: "Ваня",
//             userAvatar: (UIImage(named: "person2")),
//             userPhotos: [UIImage(named: "person5"), UIImage(named: "person3"), UIImage(named: "person2")])
//    ]
//}

//class FriendsFacory {
//
//    let friendsList = [
//        "Коля",
//        "Вася",
//        "Василек",
//        "Juan",
//        "Петров Николай",
//        "Аня",
//        "Аня",
//        "Анюшка",
//        "Андрей",
//        "Август",
//        "Иван",
//        "Лука",
//        "Bob Ib",
//        "Valentina",
//        "Анна"
//    ]
//
//    let avatarsFriendsList: [UIImage?] = [
//        UIImage(named: "person1"),
//        UIImage(named: "person2"),
//        UIImage(named: "person3"),
//        UIImage(named: "person4"),
//        UIImage(named: "person5")
//    ]
//
//    let photosFriendsList: [UIImage?] = [
//        UIImage(named: "person1"),
//        UIImage(named: "person2"),
//        UIImage(named: "person3"),
//        UIImage(named: "person4"),
//        UIImage(named: "person5")
//    ]
//
//    func makeFriendsList() -> [User] {
//        var usersList: [User] = []
//
//        for friend in friendsList {
//            let user = User(userName: friend,
//                            userAvatar: (avatarsFriendsList.randomElement()!!),
//                            userPhotos: [photosFriendsList.randomElement()!!, photosFriendsList.randomElement()!!, photosFriendsList.randomElement()!!, photosFriendsList.randomElement()!!, photosFriendsList.randomElement()!!, photosFriendsList.randomElement()!!])
//
//            usersList.append(user)
//        }
//
//        return usersList
//    }
//
// }
