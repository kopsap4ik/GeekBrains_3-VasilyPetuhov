//
//  LikeControl.swift
//  Client VK
//
//  Created by Василий Петухов on 21.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    // инициализация при вызове из кода
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLikeControl()
    }
    
    // инициализация при использовании в storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLikeControl()
    }
    
    var countLikes = 0
    var userLiked = false
    
    @IBInspectable var colorNoLike: UIColor = UIColor.white {
        didSet {
            likeImgView.tintColor = colorNoLike
            labelLikes.textColor = colorNoLike
        }
    }
    @IBInspectable var colorYesLike: UIColor = UIColor.red
    
    // картинка сердечка
    //let likeImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
    let likeImgView = UIImageView(image: UIImage(systemName: "heart"))
    // количество лайков
    let labelLikes = UILabel(frame: CGRect(x: 23, y: -1, width: 40, height: 20))
    
    // настройка контрола
    func setupLikeControl() {
        //настроки вью
        //self.backgroundColor = .clear
        //self.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        
        // иконка сердечко
//        let likeImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        likeImgView.image = UIImage(systemName: "heart")
        likeImgView.tintColor = colorNoLike
        likeImgView.layer.shadowColor = UIColor.gray.cgColor
        likeImgView.layer.shadowOpacity = 0.9
        likeImgView.layer.shadowRadius = 10
        likeImgView.layer.shadowOffset = CGSize.zero
        
        // количество лайков
//        let labelLikes = UILabel(frame: CGRect(x: 23, y: 0, width: (frame.size.width - 23), height: 20))
        labelLikes.text = String(countLikes)
        labelLikes.textColor = colorNoLike
        labelLikes.font = .systemFont(ofSize: 18)
        
        // добавляем иконку и текст на view
        self.addSubview(likeImgView)
        self.addSubview(labelLikes)
    }

        // момент первого нажатия (вернуть t​rue,​ если отслеживание прикосновения должно продолжиться, и f​alse​в обратном случае)
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        // анимация при тапе на сердечко
        let original = self.likeImgView.transform // начальное положение
        UIView.animate(withDuration: 0.1, delay: 0, options: [ .autoreverse], animations: {
            //self.avatarImage.frame.size = CGSize(width: self.frame.width * 0.9, height: self.frame.height * 0.9)
            self.likeImgView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            self.likeImgView.transform = original
            //self.transform = .identity // возврат состояния вьюхи
        })
        
        // статичные внешние параметры, можно добавить в анимацию
        if userLiked {
            userLiked = false
            countLikes -= 1
            labelLikes.text = String(countLikes)
            labelLikes.textColor = colorNoLike
            likeImgView.tintColor = colorNoLike
            likeImgView.image =  UIImage(systemName: "heart")
        } else {
            userLiked = true
            countLikes += 1
            labelLikes.text = String(countLikes)
            labelLikes.textColor = colorYesLike
            likeImgView.tintColor = colorYesLike
            likeImgView.image =  UIImage(systemName: "heart.fill")
        }
        return false
    }
}
