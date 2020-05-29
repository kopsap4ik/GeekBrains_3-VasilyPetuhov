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
    
    // нажатие вьюхи
//    @objc func onTap(sender: UITapGestureRecognizer) {
//        print("нажатие")
//    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroupsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        
        cell.nameGroupLabel.text = myGroupsList[indexPath.row]
        
        // задать аватар группы, если его нет в массиве, то ставится системная иконка
        if avatarsMyGroupList.count > indexPath.row  {
            let avatar = avatarsMyGroupList[indexPath.row] //четко по массиву
            //let avatar = avatarsFriendsList.randomElement()! // случайная картинка из массива
            cell.avatarGroupView.avatarImage.image = avatar
        }
        
        // нажатие вьюхи
//        let tapAvatarsView = UITapGestureRecognizer(target: self, action:  #selector(onTap))
//        cell.avatarGroupView.addGestureRecognizer(tapAvatarsView)
        
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
        // добавление новой группы из другого контроллера
        // проверка по идентификатору верный ли переход с ячейки
        if segue.identifier == "AddGroup"{
            // ссылка объект на контроллер с которого переход
            guard let newGroupFromController = segue.source as? NewGroupTableViewController else { return }
            
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
