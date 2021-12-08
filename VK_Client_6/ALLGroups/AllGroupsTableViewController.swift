//
//  AllGroupsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    
    
     var allGroups = [
        Group(groupName: "Swift", groupImage: .init(imageLiteralResourceName: "swift")),
        Group(groupName: "Enduro Motorsport", groupImage: .init(imageLiteralResourceName: "endu")),
        Group(groupName: "World Trading", groupImage: .init(imageLiteralResourceName: "trading"))
        ]
    
    private var filteredGroups = [Group]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
         return searchController.isActive && !searchBarIsEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            filteredGroups.count
        }
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupsTableViewCell
        
        var allGroup: Group
        
        if isFiltering {
            allGroup = filteredGroups[indexPath.row]
        } else {
            allGroup = allGroups[indexPath.row]
        }
        
        //let allGroup = allGroups[indexPath.row]
        cell.groupName.text = allGroup.groupName
        cell.groupImage.image = allGroup.groupImage

        return cell
    }

}
extension AllGroupsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String){
        filteredGroups = allGroups.filter({ (res: Group) -> Bool in
            return res.groupName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

}
