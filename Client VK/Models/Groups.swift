//
//  Groups.swift
//  Client VK
//
//  Created by Василий Петухов on 20.07.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

struct Group: Equatable {
    let groupName: String
    let groupLogo: UIImage?
    
    // для проведения сравнения (.contains), только по имени
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.groupName == rhs.groupName //&& lhs.groupLogo == rhs.groupLogo
    }
}
