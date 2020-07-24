//
//  Session.swift
//  Client VK
//
//  Created by Василий Петухов on 24.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    static let instance = Session()
    
    var token: String = "" // хранение токена в VK
    var userId: Int = 0 // хранение идентификатора пользователя VK
    
}
