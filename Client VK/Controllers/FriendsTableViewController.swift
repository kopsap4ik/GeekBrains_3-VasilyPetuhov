//
//  FriendsTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 22.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        makeNamesList()
        sortCharacterOfNamesAlphabet()
    }
    
    let friendsList = [
        User(userName: "Коля",
             userAvatar: (UIImage(named: "person1")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3"), UIImage(named: "person4"), UIImage(named: "person5")]),
        User(userName: "Ваня",
             userAvatar: (UIImage(named: "person2")),
             userPhotos: [UIImage(named: "person5"), UIImage(named: "person3"), UIImage(named: "person2")]),
        User(userName: "Василек",
             userAvatar: (UIImage(named: "person3")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4")]),
        User(userName: "Juan",
             userAvatar: (UIImage(named: "person4")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3")]),
        User(userName: "Петров Николай",
             userAvatar: (UIImage(named: "person5")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person5")]),
        User(userName: "Аня",
             userAvatar: (UIImage(named: "person2")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person5")]),
        User(userName: "Иван",
             userAvatar: (UIImage(named: "person5")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3")]),
        User(userName: "Bob Ib",
             userAvatar: (UIImage(named: "person3")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4"), UIImage(named: "person5")]),
        User(userName: "Анна",
             userAvatar: (UIImage(named: "person4")),
             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4"), UIImage(named: "person3"), UIImage(named: "person5")])
    ]
    
    var namesListFixed: [String] = [] //эталонный массив с именами для сравнения при поиске
    var namesListModifed: [String] = [] // массив с именами меняется (при поиске) и используется в таблице
    var letersOfNames: [String] = []
    
    
    // MARK: - functions
    
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
    
    func getAvatarFriendForCell(_ indexPath: IndexPath) -> UIImage? {
        for friend in friendsList {
            let namesRows = getNameFriendForCell(indexPath)
            if friend.userName.contains(namesRows) {
                return friend.userAvatar
            }
        }
        return nil
    }
    
    func getPhotosFriend(_ indexPath: IndexPath) -> [UIImage?] {
        var photos = [UIImage?]()
        for friend in friendsList {
            let namesRows = getNameFriendForCell(indexPath)
            if friend.userName.contains(namesRows) {
                photos.append(contentsOf: friend.userPhotos)
                //return friend.userPhotos
            }
        }
        return photos
    }
    
    
    // MARK: - searchBar
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
    
    // MARK: - Table view
    
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
    
    // хедер тайтл (заглавная буква имен) не работает, если используется "viewForHeaderInSection"
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return letersOfNames[section]
    //    }
    
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
        cell.nameFriendLabel.text = getNameFriendForCell(indexPath)
        cell.avatarFriendView.avatarImage.image = getAvatarFriendForCell(indexPath)
        
        return cell
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - segue
    
    // переход на экран с коллекцией фоток + передача фоток конкретного пользователя
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListUsersPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let photosFriend = segue.destination as? PhotosFriendCollectionViewController else { return }
            
            // индекс нажатой ячейки
            if let indexPath = tableView.indexPathForSelectedRow {
                photosFriend.title = getNameFriendForCell(indexPath) //тайтл экрана (имя пользователя)
                photosFriend.collectionPhotos = getPhotosFriend(indexPath) // все фотки пользователя
                
            }
        }
    }
    
}
