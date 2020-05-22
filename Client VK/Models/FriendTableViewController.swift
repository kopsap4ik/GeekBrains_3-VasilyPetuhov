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
        "Василек",
        "Juan",
        "Петров Николай",
        "Аня",
        "Аня",
        "Анюшка",
        "Андрей",
        "Август",
        "Иван",
        "Лука",
        "Bob Ib",
        "Valentina",
        "Анна"
    ]
    
    var letersOfNames: [String] = []

    var avatarsFriendsList: [UIImage?] = [
        UIImage(named: "person1"),
        UIImage(named: "person2"),
        UIImage(named: "person3"),
        UIImage(named: "person4"),
        UIImage(named: "person5")
    ]
    
    //let characterNames: [Character] = [A-Z]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создаем сортированный массив из первых букв имен
        sortCharacterOfNamesAlphabet()
    }

    // MARK: - Table view data source

    // созданием массива из начальных букв имен пользователй по алфавиту
    func sortCharacterOfNamesAlphabet() {
        var letersSet = Set<Character>()
        // сделать проверку на пустой массив (нет пользователей)
        
        // создание сета из первых букв имени, чтобы не было повторов
        for name in friendsList {
            letersSet.insert(name[name.startIndex])
        }
        
        // заполнение массива строк из букв имен
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letersOfNames.count
    }
    
    // список букв для навигации
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    
    // хедер тайтл (заглавная буква имен)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letersOfNames[section]
    }
    
    // количество ячеек в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву
        for user in friendsList {
            if letersOfNames[section].contains(user.first!) {
               countOfRows += 1
            }
        }
        return countOfRows
    }
    
    var arrayNames = [String]()
    // запонение ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса FriendTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendTableViewCell
        
        // задать имя пользователя (ищет по буквам для расстановки по секциям) + сортировка по алфавиту
        var usersRow = [String]()
        for user in friendsList.sorted() {
            if letersOfNames[indexPath.section].contains(user.first!) {
                usersRow.append(user)
            }
        }
        cell.nameFriendLabel.text = usersRow[indexPath.row]
        
        // задать аватар пользователя, если его нет в массиве, то ставится системная иконка
        if avatarsFriendsList.count > indexPath.row  {
            let avatar = avatarsFriendsList[indexPath.row] //четко по массиву
            //let avatar = avatarsFriendsList.randomElement()! // случайная картинка из массива
            cell.avatarFriendView.avatarImage.image = avatar
        }
        
        // показывать итоговую ячейку
        return cell
    }
    
    // кратковременное подсвечивание при нажатии на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
