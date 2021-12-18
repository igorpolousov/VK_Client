//
//  AllGroupsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    
    
     var allGroups = [Group]()
    
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
        
        cell.groupName.text = allGroup.name
        if let url = URL(string: allGroup.photo200) {
            if let data = try? Data(contentsOf: url) {
                cell.groupImage.image = UIImage(data: data)
            }
        }

        return cell
    }

}
extension AllGroupsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String){
        filteredGroups = allGroups.filter({ (res: Group) -> Bool in
            return res.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

}
