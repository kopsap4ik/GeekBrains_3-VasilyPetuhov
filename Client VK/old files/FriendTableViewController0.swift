////
////  FriendTableViewController.swift
////  Client VK
////
////  Created by Василий Петухов on 14.05.2020.
////  Copyright © 2020 Vasily Petuhov. All rights reserved.
////
//
//import UIKit
//
//class FriendTableViewController0: UITableViewController, UISearchBarDelegate {
//
//    @IBOutlet weak var searchBar: UISearchBar!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // для поиска
//        tableView.dataSource = self
//        searchBar.delegate = self
//
//        //        searchList = friendsList
//        makeNamesList()
//
//        //поисковый бар (добавление через код)
//        //searchController = UISearchController(searchResultsController: nil)
//        //tableView.tableHeaderView = searchController.searchBar
//
//        // создаем сортированный массив из первых букв всех доступных имен
//        sortCharacterOfNamesAlphabet()
//    }
//
//    //поисковый бар (добавление через код)
//    //var searchController: UISearchController!
//
//    let friendsList = [
//        User(userName: "Коля",
//             userAvatar: (UIImage(named: "person1")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3"), UIImage(named: "person4")]),
//        User(userName: "Ваня",
//             userAvatar: (UIImage(named: "person2")),
//             userPhotos: [UIImage(named: "person5"), UIImage(named: "person3"), UIImage(named: "person2")]),
//        User(userName: "Василек",
//             userAvatar: (UIImage(named: "person3")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4")]),
//        User(userName: "Juan",
//             userAvatar: (UIImage(named: "person4")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3")]),
//        User(userName: "Петров Николай",
//             userAvatar: (UIImage(named: "person5")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person5")]),
//        User(userName: "Аня",
//             userAvatar: (UIImage(named: "person2")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person5")]),
//        User(userName: "Иван",
//             userAvatar: (UIImage(named: "person5")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person3")]),
//        User(userName: "Bob Ib",
//             userAvatar: (UIImage(named: "person3")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4"), UIImage(named: "person5")]),
//        User(userName: "Анна",
//             userAvatar: (UIImage(named: "person4")),
//             userPhotos: [UIImage(named: "person1"), UIImage(named: "person2"), UIImage(named: "person4"), UIImage(named: "person3"), UIImage(named: "person5")])
//    ]
//
//    var searchList: [String] = []
//    var letersOfNames: [String] = []
//
//
//    // MARK: - functions
//
//    // создание массива из имен пользователей
//    func makeNamesList() {
//        for item in 0...(friendsList.count - 1){
//            searchList.append(friendsList[item].userName)
//        }
//    }
//
//    // поиск по именам
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //        searchList = searchText.isEmpty ? friendsList : friendsList.filter { (item: String) -> Bool in
//        searchList = searchText.isEmpty ? searchList : searchList.filter { (item: String) -> Bool in
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//        sortCharacterOfNamesAlphabet() // создаем заново массив заглавных букв для хедера
//        tableView.reloadData()
//    }
//
//    // отмена поиска (через кнопку Cancel)
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true // показыть кнопку Cancel
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false // скрыть кнопку Cancel
//        searchBar.text = nil
//        //        searchList = friendsList // возвращаем массив имен
//        makeNamesList() // возвращаем массив имен
//        sortCharacterOfNamesAlphabet()  // создаем заново массив заглавных букв для хедера
//        tableView.reloadData() //обновить таблицу
//        searchBar.resignFirstResponder() // скрыть клавиатуру
//    }
//
//    // созданием массива из начальных букв имен пользователй по алфавиту
//    func sortCharacterOfNamesAlphabet() {
//        var letersSet = Set<Character>()
//        letersOfNames = [] // обнуляем массив на случай повторного использования
//        // сделать проверку на пустой массив (нет пользователей)
//
//        // создание сета из первых букв имени, чтобы не было повторов
//        //        for name in friendsList {
//        for name in searchList {
//            letersSet.insert(name[name.startIndex])
//        }
//
//        // заполнение массива строк из букв имен
//        for leter in letersSet.sorted() {
//            letersOfNames.append(String(leter))
//        }
//    }
//
//    // количество секций
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return letersOfNames.count
//    }
//
//    // список букв для навигации (справа контрол)
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return letersOfNames
//    }
//
//    // настройка хедера ячеек и добавление букв в него
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3) // прозрачность только хедера
//        //header.alpha = 0.3
//
//        let leter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
//        leter.textColor = UIColor.black.withAlphaComponent(0.5)  // прозрачность только надписи
//        leter.text = letersOfNames[section]
//        leter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
//        header.addSubview(leter)
//
//        return header
//    }
//
//    // хедер тайтл (заглавная буква имен) не работает, если используется "viewForHeaderInSection"
//    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    //        return letersOfNames[section]
//    //    }
//
//    // количество ячеек в секции
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var countOfRows = 0
//        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву
//        //        for user in friendsList {
//        for user in searchList {
//            if letersOfNames[section].contains(user.first!) {
//                countOfRows += 1
//            }
//        }
//        return countOfRows
//    }
//
//    // запонение ячеек
//    var arrayNames = [String]()
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // получить ячейку класса FriendTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
//
//        //cell.backgroundColor = UIColor.cyan
//
//        // задать имя пользователя (ищет по буквам для расстановки по секциям) + сортировка по алфавиту
//        var usersRow = [String]()
//        //        for user in friendsList.sorted() {
//        for user in searchList.sorted() {
//            if letersOfNames[indexPath.section].contains(user.first!) {
//                usersRow.append(user)
//            }
//        }
//        cell.nameFriendLabel.text = usersRow[indexPath.row]
//
//
//
//        // задать аватар пользователя, если его нет в массиве, то ставится системная иконка
//        //        if avatarsFriendsList.count > indexPath.row  {
//        //            let avatar = avatarsFriendsList[indexPath.row] //четко по массиву
//        //let avatar = avatarsFriendsList.randomElement()! // случайная картинка из массива
////        let avatar = friendsList[indexPath.row].userAvatar //четко по массиву
//
////        let avatar = friendsList
////        cell.avatarFriendView.avatarImage.image = avatar
//        //        }
//
//        // показывать итоговую ячейку
//        return cell
//    }
//
//    // кратковременное подсвечивание при нажатии на ячейку
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//}
//
//
////    var friendsList = [
////        "Коля",
////        "Вася",
////        "Василек",
////        "Juan",
////        "Петров Николай",
////        "Аня",
////        "Аня",
////        "Анюшка",
////        "Андрей",
////        "Август",
////        "Иван",
////        "Лука",
////        "Bob Ib",
////        "Valentina",
////        "Анна"
////    ]
////    var avatarsFriendsList: [UIImage?] = [
////        UIImage(named: "person1"),
////        UIImage(named: "person2"),
////        UIImage(named: "person3"),
////        UIImage(named: "person4"),
////        UIImage(named: "person5")
////    ]
