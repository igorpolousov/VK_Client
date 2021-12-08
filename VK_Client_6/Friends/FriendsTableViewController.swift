//
//  FriendsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
  


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        

    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && !v.isEmpty {
            return "В"
        } else if section == 1 && !g.isEmpty {
            return "Г"
        } else if section == 2 && !ch.isEmpty {
            return "Ч"
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nameArray.count
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return v.count
        } else if section == 1 {
            return g.count
        } else if section == 2 {
            return ch.count
        }
        return 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // задали название контроллера назначения
        let vc = segue.destination as! FriendsPhotoController
        // задали название для номера строкии в таблице
        let index = tableView.indexPathForSelectedRow?.section
        let rowIndex = tableView.indexPathForSelectedRow?.row
        // передаем значение из массива друзей соотвественно номера индекса в контроллер назначения
        if index == 0 {
            vc.friendPhoto = v[rowIndex!]
        } else if index == 1 {
            vc.friendPhoto = g[rowIndex!]
        } else if index == 2 {
            vc.friendPhoto = ch[rowIndex!]
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let vName = v[indexPath.row]
            cell.friendName.text = vName.name
            cell.friendPhoto.image = vName.image
            return cell
            
        } else  if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let gName = g[indexPath.row]
            cell.friendName.text = gName.name
            cell.friendPhoto.image = gName.image
            return cell
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let chName = ch[indexPath.row]
            cell.friendName.text = chName.name
            cell.friendPhoto.image = chName.image
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
