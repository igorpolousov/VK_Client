//
//  FriendsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchResultsUpdating {
    

    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    var filteredFriendsNames = [FriendTable]()
    var friendsToLoad = [FriendForTable]()
    
    var friendsObserver: Results<FriendR>?
    var token: NotificationToken?
    
    // 1. Добавить контроллер для поиска
    let searchController = UISearchController(searchResultsController: nil)
    // 2. Добавить проверку есть текст в строке поиска или нет
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    // 3. Проверка для выбора какой массив данных использовать в таблице
    var isFiltering: Bool {
        return !searchBarIsEmpty && searchController.isActive
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 4. Начальные данные для поискового контроллера при загрузке View
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter text for search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        friendsObserver = getDataFromRealm()
        
        self.token = self.friendsObserver?.observe(on: .main, { [weak self] (changes: RealmCollectionChange) in
            self?.friendsObserver = getDataFromRealm()
            friendsName = fromRealmToTable((self?.friendsObserver)!)
            self?.friendsToLoad = convertedNames(friendsName)
            self?.tableView.reloadData()
        })
       
        //tableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "city, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let url = urlComponents.url!
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            print("FRIENDS NAME")
            print(friendsName)
            addToRealmDataBase()
            //return
        }
        
       
        friendsToLoad = sortedFriends
     
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(FriendsContainer.self, from: json) {
            friends = jsonContainer.response.items
            print(friends)
            transfer()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if !isFiltering {
            //friendsToLoad = sortedFriends
            return friendsToLoad.count
        }
        if isFiltering {
            friendsToLoad = convertedNames(filteredFriendsNames)
            return  friendsToLoad.count
        }
        return  friendsToLoad.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if friendsToLoad[section].sectionObjects.isEmpty {
            return nil
        } else {
            return friendsToLoad[section].sectionName.uppercased()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return friendsToLoad[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
            let section = friendsToLoad[indexPath.section]
            let sectionObject = section.sectionObjects
            
            cell.friendName.text = "\(sectionObject[indexPath.row].firstName)  \(sectionObject[indexPath.row].lastName)"
            if let url = URL(string: sectionObject[indexPath.row].photo50) {
                if let data = try? Data(contentsOf: url) {
                    cell.friendPhoto.image = UIImage(data: data)
                }
            }
            return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "friendPhoto") as? FriendsPhotoController {
            vc.friendPhoto = friendsToLoad[indexPath.section].sectionObjects[indexPath.row].photo50
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 5. Получение текста из поисковой строки
    func updateSearchResults(for searchController: UISearchController) {
        filteredResults(searchController.searchBar.text!)
    }
    
    // 6. Поисковая функция
    func filteredResults(_ searchText: String) {
        filteredFriendsNames = friendsName.filter { $0.lastName.uppercased().contains(searchText.uppercased()) || $0.firstName.uppercased().contains(searchText.uppercased()) }
      tableView.reloadData()
    }
    
}


