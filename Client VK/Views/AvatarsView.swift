//
//  AvatarsView.swift
//  Client VK
//
//  Created by Василий Петухов on 22.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class AvatarsView: UIView {
    
    // инициализация при вызове из кода
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAvatarView()
    }
    
    // инициализация при использовании в storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAvatarView()
    }
    
//    let avatarImage = UIImageView()
//    @IBInspectable var avatar: UIImage = UIImage(systemName: "person")! {
//        didSet {
//            avatarImage.image = avatar
//        }
//    }
    
    let avatarImage: UIImageView = UIImageView(image: UIImage(systemName: "person"))    
//    let avatarImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    func setupAvatarView(){
        // настройка основной вьюхи, где тень
        frame = CGRect(x: 10, y: frame.midY-25, width: 50, height: 50)
        backgroundColor = UIColor.white
        layer.cornerRadius = CGFloat(25.0)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize.zero
        
        // настройка аватарки
        //avatarImage.image = UIImage(named: "person1")
        //avatarImage.image = UIImage(systemName: "person")
        avatarImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.layer.cornerRadius = CGFloat(25.0)
        avatarImage.layer.masksToBounds = true
        
        self.addSubview(avatarImage)
    }
}
