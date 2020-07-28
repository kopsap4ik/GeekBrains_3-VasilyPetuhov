//
//  CustomNavigationController.swift
//  Client VK
//
//  Created by Василий Петухов on 04.06.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.delegate = self
//        self.delegate = self
        delegate = self
    }
    
// делегаты:
    // переходы по тапам на кнопки/поля
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            //присвоить свойству объекта тот viewController, для которого хотим сделать интерактивный переход
            self.interactiveTransition.viewController = toVC
        
            return animatorTwist90Push()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return animatorTwist90Pop()
        }
        return nil // если ни тот вариант и ни другой (как такое может быть не понятно)
    }
    
    // использование обработчика свайпов переход по свайпу (назад)
    let interactiveTransition = CustomInteractiveTransition()
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
}

// расширение для класса, можно и так использовать, а не дописывать сразу в класс
//extension CustomNavigationController: UINavigationControllerDelegate{
//
//    // переходы по тапам на кнопки/поля
//    func navigationController(
//        _ navigationController: UINavigationController,
//        animationControllerFor operation: UINavigationController.Operation,
//        from fromVC: UIViewController,
//        to toVC: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .push {
//            return animatorTwist90Push()
//        } else if operation == .pop {
//            return animatorTwist90Pop()
//            //return nil
//        }
//        return nil // если ни тот вариант и ни другой (как такое может быть не понятно)
//    }
//}

// анимация перехода впред через кнопку
class animatorTwist90Push: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // надо бы проверять гуардами, так как может не быть этих контроллеров
        let source = transitionContext.viewController(forKey: .from)! //откуда переход (источник)
        let destination = transitionContext.viewController(forKey: .to)! //куда переход (цель)
//        guard let source = transitionContext.viewController(forKey: .from) else { return }
//        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame //контейнер (экран)
        
        let sourceViewFrame = CGRect( //это размеры и положение фрейма где окажется источник после анимации (слева)
            x: -containerViewFrame.height,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        let destinationViewFrame = source.view.frame // это фрейм где окажется цель после анимации
        
        transitionContext.containerView.addSubview(destination.view) // добавить в контейнер цель
        
        destination.view.transform = CGAffineTransform(rotationAngle: -(.pi/2)) // переворот вью цели на 90градусов
        destination.view.frame = CGRect( //это размеры и положение фрейма цели перед анимацией (справа и повернут)
            x: containerViewFrame.width,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        //анимация
        UIView.animate(
            withDuration: duration,
            animations: {
                source.view.transform = CGAffineTransform(rotationAngle: .pi/2) // переворот вью на 90градусов
                source.view.frame = sourceViewFrame // вывод из окна источника
                
                destination.view.transform = .identity // обратный поворот цели
                destination.view.frame = destinationViewFrame // ввод в окно цели
        }) { finished in
            //source.removeFromParent() // не нужно, так как некуда будет вернуться
            transitionContext.completeTransition(finished)
        }
    }

}

// анимация возрата назад через кнопку
class animatorTwist90Pop: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // надо бы проверять гуардами, так как может не быть этих контроллеров
        let source = transitionContext.viewController(forKey: .from)! //откуда переход (источник)
        let destination = transitionContext.viewController(forKey: .to)! //куда переход (цель)
//        guard let source = transitionContext.viewController(forKey: .from) else { return }
//        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        let containerViewFrame = transitionContext.containerView.frame //контейнер (экран)
        
        let sourceViewFrame = CGRect( //это размеры и положение фрейма где окажется источник после анимации (справа)
            x: containerViewFrame.width,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        let destinationViewFrame = source.view.frame // это фрейм где окажется цель после анимации
        
        transitionContext.containerView.addSubview(destination.view) // добавить в контейнер цель
        //transitionContext.containerView.addSubview(source.view) // добавить в контейнер источник (чтобы он был над целью)
        
        //destination.view.transform = CGAffineTransform(rotationAngle: .pi/2) // переворот вью цели на 90градусов
        destination.view.frame = CGRect( //это размеры и положение фрейма цели перед анимацией (слева и повернут)
            x: -containerViewFrame.height,
            y: 0,
            width: source.view.frame.height,
            height: source.view.frame.width
        )
        
        //анимация
        UIView.animate(
            withDuration: duration,
            animations: {
                source.view.frame = sourceViewFrame // вывод из окна источника
                source.view.transform = CGAffineTransform(rotationAngle: -.pi/2) // переворот вью на 90 градусов
                
                destination.view.transform = .identity // обратный поворот цели
                destination.view.frame = destinationViewFrame // ввод в окно цели
                
        }) { finished in
            //source.removeFromParent()
            transitionContext.completeTransition(finished)
        }
    }

}

// обработка свайпа пальцем (перехода назад свайпом)
class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    // свойство, которое будет хранить UIViewController — экран, для которого будет выполняться интерактивный переход
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(
                target: self,
                action: #selector(handleScreenEdgeGesture))
            
                recognizer.edges = [.left]
                viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    // обработка жеста свайпа
    var hasStarted: Bool = false
    var shouldFinish: Bool = false

    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            //let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1) //ломается анимашка с поворотом при свайпе, так как экран перевернут и ось Х это ось У
            let relativeTranslation = translation.y / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.1

            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
}

// аниматор крутит окна всегда вверх
//class animatorMoveUp: NSObject, UIViewControllerAnimatedTransitioning {
//    let duration = 1.0
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        // надо бы проверять гуардами, так как может не быть этих контроллеров
//        let source = transitionContext.viewController(forKey: .from)! //откуда переход (источник)
//        let destination = transitionContext.viewController(forKey: .to)! //куда переход (цель)
//
//        let containerViewFrame = transitionContext.containerView.frame //контейнер (экран)
//
//        let sourceViewFrame = CGRect( //это размеры и положение фрейма где окажется источник после анимации (над контейнером)
//            x: 0,
//            y: -containerViewFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height
//        )
//
//        let destinationViewFrame = source.view.frame // это фрейм где окажется цель после анимации
//
//        transitionContext.containerView.addSubview(destination.view) // добавить в контейнер цель
//
//        destination.view.frame = CGRect( //это размеры и положение фрейма цели перед анимацией (под контейнером)
//            x: 0,
//            y: containerViewFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height
//        )
//
//        //анимация
//        UIView.animate(
//            withDuration: duration,
//            animations: {
//                source.view.frame = sourceViewFrame
//                destination.view.frame = destinationViewFrame
//        }) { finished in
//            //source.removeFromParent()  // удалить источник, но тогда некуда будет вернуться...
//            transitionContext.completeTransition(finished)
//        }
//    }
//
//}
