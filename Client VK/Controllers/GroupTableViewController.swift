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
import FirebaseDatabase

class GroupTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        subscribeToNotificationRealm() // загрузка данных из реалма (кэш) для первоначального отображения

        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetGroupsList().loadData()
    }
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()
    
    lazy var groupsFromRealm: Results<Group> = {
        return realm.objects(Group.self)
    }()
    
    var notificationToken: NotificationToken?
    
    var myGroups: [Group] = []
    

    // MARK: - TableView

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
            
            // удаление группы из реалма + обновление таблички из Реалма
            do {
                try realm.write{
                    realm.delete(groupsFromRealm.filter("groupName == %@", myGroups[indexPath.row].groupName))
                }
            } catch {
                print(error)
            }
            
            // удаление группы только из таблицы (не нужно, так как данные берутся из Реалма)
            //            myGroups.remove(at: indexPath.row)
            //            tableView.deleteRows(at: [indexPath], with: .fade) // не обязательно удалять строку, если используется reloadData()
            //tableView.reloadData()
        }
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Functions
    
    private func subscribeToNotificationRealm() {
        notificationToken = groupsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadGroupsFromRealm()
            //case let .update (_, deletions, insertions, modifications):
            case .update:
                self?.loadGroupsFromRealm()

                //self?.tableView.beginUpdates()
                
                // крашится при вызове, так как не попадает в секции, надо перерабатывать логику
                //self?.tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                //self?.tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                //self?.tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                
                //self?.tableView.endUpdates()
                

            case let .error(error):
                print(error)
            }
        }
    }
    
    func loadGroupsFromRealm() {
            myGroups = Array(groupsFromRealm)
            guard groupsFromRealm.count != 0 else { return } // проверка, что в реалме что-то есть
            tableView.reloadData()
    }
    
    
    // MARK: - Segue
        
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
                    guard myGroups.description.contains(newGroup.groupName) == false else { return }
                    
                    // добавить новую группу (не нужно, так как все берется из Реалма)
                    //myGroups.append(newGroup)
                    
                    //  добавление новой группы в реалм
                    do {
                        try realm.write{
                            realm.add(newGroup)
                        }
                    } catch {
                        print(error)
                    }
                    
                    writeNewGroupToFirebase(newGroup) // работа с Firebase
                    
                }
            }
        }
    
    // MARK:  - Firebase
    
    private func writeNewGroupToFirebase(_ newGroup: Group){
        // работаем с Firebase
        let database = Database.database()
        // путь к нужному пользователю в Firebase (тот кто залогинился уже есть базе, другие не интересны)
        let ref: DatabaseReference = database.reference(withPath: "All logged users").child(String(Session.instance.userId))
        
        // чтение из Firebase
        ref.observe(.value) { snapshot in
            
            let groupsIDs = snapshot.children.compactMap { $0 as? DataSnapshot }
                .compactMap { $0.key }
            
            // проверка есть ли ID группы в Firebase
            guard groupsIDs.contains(String(newGroup.id)) == false else { return }
    
            //ref.removeAllObservers() // отписываемся от уведомлений, чтобы не происходило изменений при изменении базы
            ref.child(String(newGroup.id)).setValue(newGroup.groupName) // записываем новую группу в Firebase
            
            print("Для пользователя с ID: \(String(Session.instance.userId)) в Firebase записана группа:\n\(newGroup.groupName)")
            
            let groups = snapshot.children.compactMap { $0 as? DataSnapshot }
            .compactMap { $0.value }
            
            print("\nРанее добавленные в Firebase группы пользователя с ID \(String(Session.instance.userId)):\n\(groups)")
            ref.removeAllObservers() // отписываемся от уведомлений, чтобы не происходило изменений при записи в базу
        }
    }
    

}
