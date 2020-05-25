//
//  NewGroupTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 15.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit


class NewGroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var GroupsList = [
        "Самая лучшая группа",
        "SWIFT для iOS",
        "Смешарики",
        "Веселые картинки",
        "Умные истории"
    ]

    var avatarsGroupList: [UIImage?] = [
        UIImage(named: "group1"),
        UIImage(named: "group2"),
        UIImage(named: "group3"),
        UIImage(named: "group4"),
        UIImage(named: "group5"),
    ]
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddGroup", for: indexPath)  as! NewGroupTableViewCell

        cell.nameNewGroupLabel.text = GroupsList[indexPath.row]
        
        // задать аватар пользователя, если его нет в массиве, то ставится системная иконка
        if avatarsGroupList.count > indexPath.row  {
            let avatar = avatarsGroupList[indexPath.row] //четко по массиву
            //let avatar = avatarsGroupList.randomElement()! // случайная картинка из массива
            cell.avatarNewGroupView.avatarImage.image = avatar
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // кратковременное подсвечивание при нажатии на ячейку
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
