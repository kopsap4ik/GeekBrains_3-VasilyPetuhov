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
    let labelLikes = UILabel(frame: CGRect(x: 23, y: -1, width: (40), height: 20))
    
    // настройка контрола
    func setupLikeControl() {
        //настроки вью
        //self.backgroundColor = .clear
        //self.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        
        // иконка сердечко
//        let likeImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        likeImgView.image = UIImage(systemName: "heart")
        likeImgView.tintColor = colorNoLike
        likeImgView.layer.shadowColor = UIColor.white.cgColor
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
    

    // метод для рисования можно не обращать внимание, это тест
//    override func draw(_ rect: CGRect) {
        // иконка сердечко
//        let likeImg: UIImage? = UIImage(systemName: "heart")?.withTintColor(UIColor.white)
//        likeImg?.draw(at: CGPoint(x: 0, y: 4))
        
        // количество лайков
//        let text = NSAttributedString(string: String(countLikes), attributes: [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
//        text.draw(at: CGPoint(x: 20, y: 0))
//
//
//        //рисуем линию
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 1, y: 1))
//        path.addLine(to: CGPoint(x: 45, y: 45))
//        UIColor.black.setStroke()
//        path.stroke()
//
//        // пишем текст (как скейлить непонятно)
////        let text = NSAttributedString(string: "hello")
////        text.draw(at: CGPoint(x: 10, y: 25))
//        //let textSize: CGSize = text.size()
//
//        var image: UIImage? = UIImage(named: "person1")
        //image.contentMode =
        //image?.draw(at: CGPoint(x: 0, y: 0))
        //image?.draw(in: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
//    }
