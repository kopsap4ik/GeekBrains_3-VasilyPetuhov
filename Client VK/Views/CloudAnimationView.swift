//
//  CloudAnimationView.swift
//  Client VK
//
//  Created by Василий Петухов on 01.06.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class CloudAnimationView: UIView {

        // инициализация при вызове из кода
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCloudAnimationView()
        }
        
        // инициализация при использовании в storyboard
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupCloudAnimationView()
        }
        
        func setupCloudAnimationView(){
            //облако
            let cloudPath = UIBezierPath()
            cloudPath.move(to: CGPoint(x: 10, y: 60))
            cloudPath.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
            cloudPath.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
            cloudPath.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
            cloudPath.addQuadCurve(to: CGPoint(x: 90, y: 30), controlPoint: CGPoint(x: 85, y: 15))
            cloudPath.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 35))
            cloudPath.close()
            
            // слой для отрисовки облака
            let cloudView = CAShapeLayer()
            cloudView.path = cloudPath.cgPath
            cloudView.strokeColor = UIColor.systemBlue.cgColor
            cloudView.lineWidth = 5
            cloudView.fillColor = UIColor.clear.cgColor
            cloudView.lineCap = .round
            
            // добавить облако на слой
            self.layer.addSublayer(cloudView)
            
            // анимашка стирания
            let animationStart = CABasicAnimation(keyPath: "strokeStart")
            animationStart.beginTime = 0.5
            animationStart.fromValue = 0
            animationStart.toValue = 1
            animationStart.duration = 2
            
            // анимашка рисования
            let animationEnd = CABasicAnimation(keyPath: "strokeEnd")
            //animationEnd.beginTime = 0
            animationEnd.fromValue = 0
            animationEnd.toValue = 1
            animationEnd.duration = 2
            
            // группа из двух анимаций
            let groupAnimation = CAAnimationGroup()
            groupAnimation.duration = 2.5 // так как анимация каждая по 2сек + 0.5 задержка
            groupAnimation.fillMode = CAMediaTimingFillMode.backwards
            groupAnimation.repeatCount = .infinity // бесконечно крутится
            groupAnimation.isRemovedOnCompletion = false
            groupAnimation.animations = [animationStart, animationEnd]
            
            cloudView.add(groupAnimation, forKey: nil)

        }

}
