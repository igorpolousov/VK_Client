//
//  MyGroupsViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 30.03.2021.
//

import UIKit

class MyGroupsViewController: UITableViewController {

    
    var  myGroups = [Group]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue){
        
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else {return}
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow{
                
                let group = allGroupsController.allGroups[indexPath.row]
                
                if !myGroups.contains(group){
                    myGroups.append(group)
                    
                    tableView.reloadData()
                }
            }
        }
    }
    
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsViewCell
            
            let group = myGroups[indexPath.row]
            
            cell.groupImage.image = group.groupImage
            cell.groupName.text = group.groupName
            
            return cell
         }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

