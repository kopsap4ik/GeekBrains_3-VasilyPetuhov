//
//  LoadingAnimationView.swift
//  Client VK
//
//  Created by Василий Петухов on 29.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class LoadingAnimationView: UIView {

        // инициализация при вызове из кода
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupLoadingAnimationView()
        }
        
        // инициализация при использовании в storyboard
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLoadingAnimationView()
        }
    
    let circle1: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let circle2: UIView = UIView(frame: CGRect(x: 30, y: 0, width: 20, height: 20))
    let circle3: UIView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
        
        func setupLoadingAnimationView(){
            // настройка основной вьюхи
            //frame = CGRect(x: 0, y: 0, width: 80, height: 20)
            
            circle1.backgroundColor = .gray
            circle1.layer.cornerRadius = self.circle1.frame.width / 2
            circle2.backgroundColor = .gray
            circle2.layer.cornerRadius = self.circle2.frame.width / 2
            circle3.backgroundColor = .gray
            circle3.layer.cornerRadius = self.circle3.frame.width / 2
        
            UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {self.circle1.alpha = 0})
            UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {self.circle2.alpha = 0})
            UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {self.circle3.alpha = 0})

            self.addSubview(circle1)
            self.addSubview(circle2)
            self.addSubview(circle3)
        }
}
