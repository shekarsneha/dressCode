//
//  ClosetTableViewController.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-21.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

import UIKit

class ClosetTableViewController: UITableViewController {
    
    var clothes = Array<Clothes>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func loadClothes (data: JSON) {
        
        clothes = Array<Clothes>()
        let clothesDataArray = data["items"].array!
        
        for data in clothesDataArray {
            clothes.append(Clothes(data: data))
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothes.count
       
    }
    
    //dislpaying table rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClothingCell", for: indexPath) as! ClosetTableViewCell

        let items = clothes[indexPath.row]
        //cell.nameLabel!.text = items["name"].stringValue
        //cell.clothesImageView!.image = UIImage(named: items["image"].stringValue)
        
        cell.nameLabel!.text = items.name
        cell.clothesImageView!.image = UIImage(named: items.image)
        
        return cell
    }
    
    //deleting rows from table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            clothes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextViewController = segue.destination as? ClothingItemViewController {
            
            let clothesIndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            nextViewController.transferClothesDetails(data: clothes[clothesIndexPath.row])
            
        }
        
    }

}
