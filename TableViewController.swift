//
//  TableViewController.swift
//  Dress Code
//
//  Created by Sneha Shekar on 2018-04-24.
//  Copyright © 2018 Sneha Shekar. All rights reserved.
//

//THIS SHOWS CATEGORIES OF CLOSET

import UIKit

class TableViewController: UITableViewController {
    
    var clothing = Array<JSON>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let file = Bundle(for: AppDelegate.self).path(forResource: "clothes3", ofType: "json")
        {
            let data = NSData(contentsOfFile: file) as! Data
            let json = JSON(data: data)
            self.clothing = json["Clothes"].arrayValue
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothing.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let clothes = clothing[indexPath.row]
        cell.textLabel!.text = clothes["category_name"].stringValue
        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextViewController = segue.destination as? ClosetTableViewController {
            
            let clothesIndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            nextViewController.loadClothes(data: clothing[clothesIndexPath.row])
            
        }
    }
    

}
