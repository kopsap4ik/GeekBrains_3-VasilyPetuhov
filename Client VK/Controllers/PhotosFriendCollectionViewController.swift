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
        
        subscribeToNotificationRealm()
        
        // запуск обновления данных из сети, запись в Реалм и загрузка из реалма новых данных
        GetPhotosFriend().loadData(ownerID) { [weak self] () in
            self?.loadPhotosFromRealm()
        }

    }
    
    var realm: Realm = {
        let configrealm = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: configrealm)
        return realm
    }()
    
    lazy var photosFromRealm: Results<Photo> = {
        return realm.objects(Photo.self).filter("ownerID == %@", ownerID)
    }()
    
    var notificationToken: NotificationToken?
    
    
    var ownerID = ""
    var collectionPhotos: [Photo] = []
    
    
    // MARK: - TableView
    
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
    
    
    // MARK: - Functions
    
    private func subscribeToNotificationRealm() {
        notificationToken = photosFromRealm.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.loadPhotosFromRealm()
            //case let .update (_, deletions, insertions, modifications):
            case .update:
                self?.loadPhotosFromRealm()

                // РАБОТАЕТ сначала надо изменить массив фоток, а потом удалить из коллекции
                //print(deletions.map { $0 })
                //_ = deletions.map{ self?.collectionPhotos.remove (at: $0) }
                //self?.collectionPhotos.remove(at: deletions.map{ $0 })
                
                //self?.collectionView.deleteItems(at: deletions.map{ IndexPath(item: $0, section: 0) })
                
            
                // крашится при удалении из реалма
                //self?.collectionView.deleteItems(at: deletions.map{ IndexPath(item: $0, section: 0) })
                //self?.collectionView.insertItems(at: insertions.map{ IndexPath(item: $0, section: 0) })
                //self?.collectionView.reloadItems(at: modifications.map{ IndexPath(item: $0, section: 0) })
                

            case let .error(error):
                print(error)
            }
        }
    }
    
    func loadPhotosFromRealm() {
            collectionPhotos = Array(photosFromRealm)
            guard collectionPhotos.count != 0 else { return } // проверка, что в реалме что-то есть
            collectionView.reloadData()
    }
    
    
    // MARK: - Segue
    
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
    
    
}
