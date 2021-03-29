//
//  FriendsTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 22.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // переработка в дженерики, нужно доработать
//        VKService().loadData(.friends) { () in
//
//        }
                
        subscribeToNotificationRealm() // подписка на нотификации реалма + обновление таблицы
        
        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetFriendsList().loadData()
        
        searchBar.delegate = self
    }
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()
    
    lazy var friendsFromRealm: Results<Friend> = {
        return realm.objects(Friend.self)
    }()
    
    var notificationToken: NotificationToken?
    
    var friendsList: [Friend] = []
    var namesListFixed: [String] = [] //эталонный массив с именами для сравнения при поиске
    var namesListModifed: [String] = [] // массив с именами меняется (при поиске) и используется в таблице
    var letersOfNames: [String] = []
    
    
    // MARK: - TableView
    
    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letersOfNames.count
    }
    
    // настройка хедера ячеек и добавление букв в него
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3) // прозрачность только хедера

        let leter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        leter.textColor = UIColor.black.withAlphaComponent(0.5)  // прозрачность только надписи
        leter.text = letersOfNames[section]
        leter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        header.addSubview(leter)

        return header
    }
    
    // список букв для навигации (справа контрол)
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    // количество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву
        for name in namesListModifed {
            if letersOfNames[section].contains(name.first!) {
                countOfRows += 1
            }
        }
        return countOfRows
    }
    
    // запонение ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса FriendTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        // задать имя пользователя (ищет по буквам для расстановки по секциям) + сортировка по алфавиту
        cell.nameFriendLabel.text = self.getNameFriendForCell(indexPath)
        
        //задать аватар для друга (грузит по ссылке: 2 способа)
        guard let imgUrl = self.getAvatarFriendForCell(indexPath) else { return cell }
            let avatar = ImageResource(downloadURL: imgUrl) //работает через Kingfisher
            cell.avatarFriendView.avatarImage.kf.indicatorType = .activity
            cell.avatarFriendView.avatarImage.kf.setImage(with: avatar)

//            cell.avatarFriendView.avatarImage.load(url: imgUrl) // работает через extension UIImageView
        return cell
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Functions
    
    private func subscribeToNotificationRealm() {
        notificationToken = friendsFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadFriendsFromRealm()
            //case let .update (_, deletions, insertions, modifications):
            case .update:
                self?.loadFriendsFromRealm()

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
    
    func loadFriendsFromRealm() {
            friendsList = Array(friendsFromRealm)
            guard friendsList.count != 0 else { return } // проверка, что в реалме что-то есть
            makeNamesList()
            sortCharacterOfNamesAlphabet()
            tableView.reloadData()
    }
    
    // создание массива из имен пользователей
    func makeNamesList() {
        namesListFixed.removeAll()
        for item in 0...(friendsList.count - 1){
            namesListFixed.append(friendsList[item].userName)
        }
        namesListModifed = namesListFixed
    }
    
    // созданием массива из начальных букв имен пользователй по алфавиту
    func sortCharacterOfNamesAlphabet() {
        var letersSet = Set<Character>()
        letersOfNames = [] // обнуляем массив на случай повторного использования
        // создание сета из первых букв имени, чтобы не было повторов
        for name in namesListModifed {
            letersSet.insert(name[name.startIndex])
        }
        // заполнение массива строк из букв имен
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    func getNameFriendForCell(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModifed.sorted() {
            if letersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }
    
    func getAvatarFriendForCell(_ indexPath: IndexPath) -> URL? {
        for friend in friendsList {
            let namesRows = getNameFriendForCell(indexPath)
            if friend.userName.contains(namesRows) {
                return URL(string: friend.userAvatar)
            }
        }
        return nil
    }
    
    func getIDFriend(_ indexPath: IndexPath) -> String {
        var ownerIDs = ""
        for friend in friendsList {
            let namesRows = getNameFriendForCell(indexPath)
            if friend.userName.contains(namesRows) {
                ownerIDs = friend.ownerID
            }
        }
        return ownerIDs
    }
    
    
    // MARK: - SearchBar
    
    // поиск по именам
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        searchList = searchText.isEmpty ? friendsList : friendsList.filter { (item: String) -> Bool in
        namesListModifed = searchText.isEmpty ? namesListFixed : namesListFixed.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        sortCharacterOfNamesAlphabet() // создаем заново массив заглавных букв для хедера
        tableView.reloadData()
    }
    
    // отмена поиска (через кнопку Cancel)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показыть кнопку Cancel
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // скрыть кнопку Cancel
        searchBar.text = nil
        makeNamesList() // возвращаем массив имен
        sortCharacterOfNamesAlphabet()  // создаем заново массив заглавных букв для хедера
        tableView.reloadData() //обновить таблицу
        searchBar.resignFirstResponder() // скрыть клавиатуру
    }
    
    
    // MARK: - Segue
    
    // переход на экран с коллекцией фоток + передача фоток конкретного пользователя
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListUsersPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let friend = segue.destination as? PhotosFriendCollectionViewController else { return }
            
            // индекс нажатой ячейки
            if let indexPath = tableView.indexPathForSelectedRow {
                friend.title = getNameFriendForCell(indexPath) //тайтл экрана (имя пользователя)
                friend.ownerID = getIDFriend(indexPath)
            }
        }
    }
    
    
}
