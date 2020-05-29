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
        tapOnView() // обработка нажатия на вьюху
        setupAvatarView()
    }
    
    // инициализация при использовании в storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tapOnView() // обработка нажатия на вьюху
        setupAvatarView()
    }
    
    // обработка тапа по аватару
    func tapOnView() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1 // сколько нажатий нужно
        //recognizer.numberOfTouchesRequired = 1 // сколько пальцев надо прижать
        self.addGestureRecognizer(recognizer) //добавить наблюдение
    }
    
    // анимация при тапе на аватар
    @objc func onTap(gestureRecognizer: UITapGestureRecognizer) {
        let original = self.transform // начальное состояние вьюхи
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.1, options: [ .autoreverse], animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // меняем размер вьюхи анимировано
        }, completion: { _ in
            self.transform = original // возврат состояния вьюхи на сохраненное значение
            //self.transform = .identity // возврат состояния вьюхи
        })
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
        layer.cornerRadius = CGFloat(self.frame.width / 2)
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
        avatarImage.layer.cornerRadius = CGFloat(self.frame.width / 2)
        avatarImage.layer.masksToBounds = true
        
        self.addSubview(avatarImage)
    }
    
}
