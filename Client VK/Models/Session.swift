//
//  Session.swift
//  Client VK
//
//  Created by Василий Петухов on 24.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class Session {
    private init() {}
    static let instance = Session()
    
    // хранение токена в VK
    var token: String {
        get{
            return KeychainWrapper.standard.string(forKey: "tokenVK") ?? ""
        }
        set{
            KeychainWrapper.standard.set(newValue, forKey: "tokenVK")
        }
    }
    
    // хранение идентификатора пользователя VK
    var userId: Int {
        get {
            return KeychainWrapper.standard.integer(forKey: "userId") ?? 0
        }
        set{
            KeychainWrapper.standard.set(newValue, forKey: "userId")
        }
    }
    
}
