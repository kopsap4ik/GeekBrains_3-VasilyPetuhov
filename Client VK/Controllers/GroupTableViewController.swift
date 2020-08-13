//
//  GroupTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GroupTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loadGroupsFromRealm() // загрузка данных из реалма (кэш) для первоначального отображения

        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetGroupsList().loadData() { [weak self] () in
            self?.loadGroupsFromRealm()
        }
    }
    
    var myGroups: [Group] = []
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupTableViewCell
        
        cell.nameGroupLabel.text = myGroups[indexPath.row].groupName
        
        if let imgUrl = URL(string: myGroups[indexPath.row].groupLogo) {
            let avatar = ImageResource(downloadURL: imgUrl) //работает через Kingfisher
            cell.avatarGroupView.avatarImage.kf.indicatorType = .activity //работает через Kingfisher
            cell.avatarGroupView.avatarImage.kf.setImage(with: avatar) //работает через Kingfisher
            
            //cell.avatarGroupView.avatarImage.load(url: imgUrl) // работает через extension UIImageView
        }
        
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
                let newGroup = newGroupFromController.GroupsList[indexPath.row]
                
//                // проверка что группа уже в списке (нужен Equatable)
                guard !myGroups.description.contains(newGroup.groupName) else { return }

                myGroups.append(newGroup)
                
                //  добавление одной новой группы в реалм
//                do {
//                    let realm = try Realm()
//                    try realm.write{
//                        realm.add(newGroup)
//                    }
//                } catch {
//                    print(error)
//                }
//                loadGroupsFromRealm()
                
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - functions
    
    func loadGroupsFromRealm() {
        do {
            let realm = try Realm()
            let groupsFromRealm = realm.objects(Group.self)
            myGroups = Array(groupsFromRealm)
            guard groupsFromRealm.count != 0 else { return } // проверка, что в реалме что-то есть
            tableView.reloadData()
        } catch {
            print(error)
        }
    }

}
