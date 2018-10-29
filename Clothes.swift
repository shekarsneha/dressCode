//
//  Clothes.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-21.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

import Foundation

class Clothes {
    
    var name: String
    var season: String
    var image: String
    
    init(data: JSON) {
        
        name = data["name"].stringValue
        season = data["season"].stringValue
        image = data["image"].stringValue
        
    }
    
}
