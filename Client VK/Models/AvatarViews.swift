//
//  AvatarViews.swift
//  Client VK
//
//  Created by Василий Петухов on 18.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

@IBDesignable class AvatarUIImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 25.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}

@IBDesignable class AvatarShadowView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 25.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
   
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.6 {
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
}

