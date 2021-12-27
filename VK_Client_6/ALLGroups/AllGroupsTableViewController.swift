//
//  AllGroupsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    var groupsSearch = [GroupSearch]()
    var allGroups: [Group]?
    
    let searchController = UISearchController(searchResultsController: nil)
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
      
       
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsSearch.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsTableViewCell
        
        cell.groupName.text = groupsSearch[indexPath.row].name
        if let url = URL(string: groupsSearch[indexPath.row].photo200) {
            if let data = try? Data(contentsOf: url) {
                cell.groupImage.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func updateSearch(_ text: String) {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "offset", value: "3"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let url = urlComponents.url!
        if let data =  try? Data(contentsOf: url) {
            self.parse(json: data)
        }
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(GroupsSearchContainer.self, from: json) {
            groupsSearch = jsonContainer.response.items
            print(groupsSearch)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsSearch = []
       
        updateSearch(searchText)
        tableView.reloadData()
    }
}


