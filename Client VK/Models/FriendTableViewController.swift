//
//  FriendTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit



class FriendTableViewController: UITableViewController {
    
    var friendsList = [
        "Коля",
        "Вася",
        "Петров Николай"
    ]

    var avatarsFriendsList: [UIImage?] = [
        UIImage(named: "person1"),
        UIImage(named: "person2"),
        UIImage(named: "person3"),
        UIImage(named: "person4"),
        UIImage(named: "person5"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса FriendTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendTableViewCell
        
        // задать имя пользователя
        let name = friendsList[indexPath.row]
        cell.nameFriendLabel.text = name
        
        // задать аватар пользователя
        let avatar = avatarsFriendsList[indexPath.row]
        cell.avatarFriendImageView.image = avatar
        
        // показывать ячейку
        return cell
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
