//
//  NewsTableViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 25.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var NewsList = [
        PostNews(name: "Victor", avatar: UIImage(named: "person1"), date: "Вчера в 17:19", textNews: "Променял Восстала исчезнет Чтя Как муж ков вер милосерд нарекший. Достояние развратом наполняет. Враждебен скрежетом примирить румянятся порицаний склонился. Им Ко Со от Уж То те Ах. Но Со цельна Свлеки Единым то До Ты Ея об. Корысть родимся радеешь Встанет болотна Молитвы.", textImage: UIImage(named: "news1")),
        PostNews(name: "Валентин", avatar: UIImage(named: "person2"), date: "14.02.2020 в 17:19", textNews: "Пламенея белизною вниманья истреблю Каратель резвятся. Ослепляет Трепещущи возвестит ему Зря лицемерья тук сим над дев. До Во Из Им ах об. . Да Ее об Он Тя вы не яд. Он тягчайший Евпраксия ах светлеясь мя Им смертного. Оно умиленье избранна созвучны вам зло бог тул воссесть льстецов скрыться. Наших место думаю потек. Муж морских Явилась стареем Величия или зло род ссужает. Своим Ее ли Забыв бы людей Вы забыл.", textImage: UIImage(named: "news2")),
        PostNews(name: "Турин", avatar: UIImage(named: "person3"), date: "27.02.2019 в 17:19", textNews: "Is education residence conveying so so. Suppose shyness say ten behaved morning had. Any unsatiable assistance compliment occasional too reasonably advantages. Unpleasing has ask acceptance partiality alteration understood two. Worth no tiled my at house added. Married he hearing am it totally removal. Remove but suffer wanted his lively length. Moonlight two applauded conveying end direction old principle but. Are expenses distance weddings perceive strongly who age domestic.", textImage: UIImage(named: "news3"))
    ]


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        // аватар
        cell.avatarUserNews.avatarImage.image = NewsList[indexPath.row].avatar
        // имя автора
        cell.nameUserNews.text = NewsList[indexPath.row].name
        // дата новости
        cell.dateNews.text = NewsList[indexPath.row].date
        cell.dateNews.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        cell.dateNews.textColor = UIColor.gray.withAlphaComponent(0.5)
        //текст новости
        cell.textNews.text = NewsList[indexPath.row].textNews
        cell.textNews.numberOfLines = 0
        //картинка к новости
        cell.imgNews.image = NewsList[indexPath.row].textImage
        cell.imgNews.contentMode = .scaleAspectFill

        return cell
    }

}
