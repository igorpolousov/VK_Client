//
//  MyGroupsViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 30.03.2021.
//

import UIKit

class MyGroupsViewController: UITableViewController {


    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroupsDataFromRealm()

        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "extended"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let url = urlComponents.url!
        if let data =  try? Data(contentsOf: url) {
            self.parse(json: data)
            addGroupsToRealmDataBase()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(GroupContainer.self, from: json) {
            myGroups = jsonContainer.response.items
            transferGroup()
            print(myGroups)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as! MyGroupsViewCell
        
        let group = groupsTable[indexPath.row]
        
        cell.groupName.text = group.groupName
        if let url = URL(string: group.photoUrl) {
            if let data = try? Data(contentsOf: url) {
                cell.groupImage.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsTable.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else {return}
            
            allGroupsController.allGroups = groupsTable
        }
    }
}


