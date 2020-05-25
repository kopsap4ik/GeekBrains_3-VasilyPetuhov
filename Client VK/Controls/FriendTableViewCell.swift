//
//  FriendTableViewCell.swift
//  Client VK
//
//  Created by Василий Петухов on 14.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameFriendLabel: UILabel!
    @IBOutlet weak var avatarFriendView: AvatarsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
