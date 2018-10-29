//
//  ClothingItemViewController.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-21.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

import UIKit

class ClothingItemViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    var name: String = ""
    var season: String = ""
    var image: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = name
       self.seasonLabel.text = season
        self.itemImageView.image = UIImage(named: image)

    }

    func transferClothesDetails(data: Clothes){
        
        self.name = data.name
        self.season = data.season
        self.image = data.image

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
