//
//  LikeButtonView.swift
//  Client VK
//
//  Created by Василий Петухов on 19.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class LikeButtonView: UIButton {

    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            tintColor = color
        }
    }
    
    @IBInspectable var icon: UIImage = UIImage(systemName: "heart")! {
         didSet {
            setImage(icon, for: .normal)
         }
     }
    
     @IBInspectable var shadowColor: UIColor = UIColor.black {
         didSet {
             layer.shadowColor = shadowColor.cgColor
         }
     }
     
     @IBInspectable var shadowOpacity: Float = 1.0 {
         didSet {
             layer.shadowOpacity = shadowOpacity
         }
     }
     
     @IBInspectable var shadowRadius: CGFloat = 5.0 {
         didSet {
             layer.shadowRadius = shadowRadius
         }
     }
     
     @IBInspectable var shadowOffset: CGSize = CGSize.zero {
         didSet {
             layer.shadowOffset = shadowOffset
         }
     }
    
//    var likePressed = false
//    //let likeButton = PhotosFriendCollectionViewCell()
//
//    func pressLikeButton() {
//
//        if !likePressed {
//            likePressed = true
//            setTitle("1", for: .normal)
//            setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            tintColor = .red
//            print(tintColor)
//
////            likeButton.likeButtonOutlet.setTitle("1", for: .normal)
////            likeButton.likeButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
////            likeButton.likeButtonOutlet.tintColor = .red
//
//        } else {
//            likePressed = false
//
//            setTitle("0", for: .normal)
//            setImage(UIImage(systemName: "heart"), for: .normal)
//            tintColor = .white
//
//            print("else")
//
////            likeButton.likeButtonOutlet.setTitle("0", for: .normal)
////            likeButton.likeButtonOutlet.setImage(UIImage(systemName: "heart"), for: .normal)
////            likeButton.likeButtonOutlet.tintColor = .white
//
//        }
//
//    }

}
