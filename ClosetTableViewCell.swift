//
//  ClosetTableViewCell.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-22.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

import UIKit

class ClosetTableViewCell: UITableViewCell {

    @IBOutlet weak var clothesImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
