//
//  GroupTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var myGroups = [
        Groups(groupName: "Самая лучшая группа", groupLogo: UIImage(named: "group1"))
    ]
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        
        cell.nameGroupLabel.text = myGroups[indexPath.row].groupName
        
        let avatar = myGroups[indexPath.row].groupLogo //четко по массиву
        cell.avatarGroupView.avatarImage.image = avatar
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) // не обязательно удалять строку, если используется reloadData()
            //tableView.reloadData()
        }
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // добавление новой группы из другого контроллера
    @IBAction func addNewGroup(segue:UIStoryboardSegue) {
        // проверка по идентификатору верный ли переход с ячейки
        if segue.identifier == "AddGroup"{
            // ссылка объект на контроллер с которого переход
            guard let newGroupFromController = segue.source as? NewGroupTableViewController else { return }
            // проверка индекса ячейки
            if let indexPath = newGroupFromController.tableView.indexPathForSelectedRow {
                //добавить новой группы в мои группы из общего списка групп
                let newGroup = newGroupFromController.allGroups[indexPath.row]
                
                // проверка что группа уже в списке (нужен Equatable)
                guard !myGroups.contains(newGroup) else { return }
                myGroups.append(newGroup)
                
                tableView.reloadData()
            }
        }
    }

}
