//
//  AvatarFriendCollectionViewCell.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class PhotosFriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photosFrienndImage: UIImageView!
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    var likePressed = false
    
    @IBAction func likeButtonAction(_ sender: Any) {
        
//        let like = LikeButtonView()
//        like.pressLikeButton()
        
        if !likePressed {
            likePressed = true
            likeButtonOutlet.setTitle("1", for: .normal)
            likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButtonOutlet.tintColor = .red

        } else {
            likePressed = false
            likeButtonOutlet.setTitle("0", for: .normal)
            likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButtonOutlet.tintColor = .white

        }

    }
    
}
