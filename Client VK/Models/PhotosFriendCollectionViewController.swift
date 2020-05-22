//
//  AvatarFriendCollectionViewController.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class PhotosFriendCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: UICollectionViewDataSource
    
    // экземпляр FriendTableViewController для доступа к переменным. Иначе их нужно вынести из класса
    let collectionPhotos = FriendTableViewController()

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return collectionPhotos.avatarsFriendsList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosFriendCell", for: indexPath) as! PhotosFriendCollectionViewCell
        
        let photo = collectionPhotos.avatarsFriendsList[indexPath.row]
        cell.photosFrienndImage.image = photo
    
        // Configure the cell
    
        return cell
    }

}
