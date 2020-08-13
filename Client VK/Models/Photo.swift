//
//  Photo.swift
//  Client VK
//
//  Created by Василий Петухов on 06.08.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit
import RealmSwift

class Photo: Object {
    @objc dynamic var photo: String = ""
    @objc dynamic var ownerID: String  = ""
    
    init(photo: String, ownerID: String) {
        self.photo = photo
        self.ownerID = ownerID
    }
    
    // этот инит обязателен для Object
    required init() {
        super.init()
    }
}
