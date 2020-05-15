//
//  GroupTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var myGroupsList: [String] = ["Самая лучшая группа"]
    var avatarsMyGroupList: [UIImage?] = [UIImage(named: "group1")]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroupsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        
        
        
        cell.nameGroupLabel.text = myGroupsList[indexPath.row]
        cell.avatarGroupImageView.image = avatarsMyGroupList[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroupsList.remove(at: indexPath.row)
            avatarsMyGroupList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewGroup(segue:UIStoryboardSegue) {
        // проверка по идентификатору верный ли переход с ячейки
        if segue.identifier == "AddGroup"{
            // ссылка на контроллер с которого переход
            guard let newGroupFromController = segue.source as? NewGroupTableViewController else { return }
            //indexPathForSelectedRow
            
            // проверка индекса ячейки
            if let indexPath = newGroupFromController.tableView.indexPathForSelectedRow {
                //добавить описание и аватар в мои группы
                let nameGroup = newGroupFromController.GroupsList[indexPath.row]
                let avatarGroup = newGroupFromController.avatarsGroupList[indexPath.row]
                
                // проверка что группа уже в списке
                guard !myGroupsList.contains(nameGroup) else { return }
                myGroupsList.append(nameGroup)
                avatarsMyGroupList.append(avatarGroup)
                
                // обновить таблицу
                tableView.reloadData()
            }

        }
    }

}
