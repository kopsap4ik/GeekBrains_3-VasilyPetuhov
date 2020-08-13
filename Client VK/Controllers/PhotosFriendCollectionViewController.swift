//
//  AvatarFriendCollectionViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class PhotosFriendCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotosFromRealm() // загрузка данных из реалма (кэш) для первоначального отображения
        
        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetPhotosFriend().loadData(ownerID) { [weak self] () in
            self?.loadPhotosFromRealm()
        }

    }
    
    var ownerID = ""
    var collectionPhotos: [Photo] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosFriendCell", for: indexPath) as! PhotosFriendCollectionViewCell
        
        if let imgUrl = URL(string: collectionPhotos[indexPath.row].photo) {
            let photo = ImageResource(downloadURL: imgUrl) //работает через Kingfisher
            cell.photosFrienndImage.kf.setImage(with: photo) //работает через Kingfisher
            
            //cell.photosFrienndImage.load(url: imgUrl)  // работает через extension UIImageView
        }
        
        return cell
    }
    
    // MARK: - segue
    // переход на контроллер с отображением крупной фотографии
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let photosFriend = segue.destination as? FriendsPhotosViewController else { return }
            
            // индекс нажатой ячейки
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                photosFriend.allPhotos = collectionPhotos //фотки
                photosFriend.countCurentPhoto = indexPath.row // можно указать (indexPath[0][1]) или использовать (?.first) как сделано выше
            }
        }
    }
    
    // MARK: - functions
    
    func loadPhotosFromRealm() {
        do {
            let realm = try Realm()
            let photosFromRealm = realm.objects(Photo.self).filter("ownerID == %@", ownerID)
            collectionPhotos = Array(photosFromRealm)
            guard collectionPhotos.count != 0 else { return } // проверка, что в реалме что-то есть
            collectionView.reloadData()
        } catch {
            print(error)
        }
    }
    
    
}
