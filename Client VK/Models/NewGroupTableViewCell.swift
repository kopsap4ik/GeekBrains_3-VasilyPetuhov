//
//  NewGroupTableViewCell.swift
//  Client VK
//
//  Created by Василий Петухов on 15.05.2020.
//  Copyright © 2020 Vasily Petuhov. All rights reserved.
//

import UIKit

class NewGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var nameNewGroupLabel: UILabel!
    @IBOutlet weak var avatarNewGroupView: AvatarsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
