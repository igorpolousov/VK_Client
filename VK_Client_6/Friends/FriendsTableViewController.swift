//
//  FriendsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    var friends = [Friend]()
    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    var friendR = FriendR()
    var friendRArray = [FriendR]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
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
            saveAppData(data: friendRArray)
            
            return
        }
        
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(FriendsContainer.self, from: json) {
            friends = jsonContainer.response.items
            print(friends)
            
            for friend in friends {
                friendR.firstName = friend.firstName
                friendR.lastName = friend.lastName
                friendR.photo50 = friend.photo50
                print(friendR)
                friendRArray.append(friendR)
                print(friendRArray)
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        cell.friendName?.text = "\(friends[indexPath.row].firstName) \(friends[indexPath.row].lastName)"
        
        if let url = URL(string: friends[indexPath.row].photo50) {
            if let data = try? Data(contentsOf: url) {
                cell.friendPhoto?.image = UIImage(data: data)
                }
            }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FriendsPhotoController
        let rowIndex = tableView.indexPathForSelectedRow?.row
        vc.friendPhoto = friends[rowIndex!]
    }
    
   

    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 && !v.isEmpty {
//            return "В"
//        } else if section == 1 && !g.isEmpty {
//            return "Г"
//        } else if section == 2 && !ch.isEmpty {
//            return "Ч"
//        }
//        return nil
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return nameArray.count
//
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return v.count
//        } else if section == 1 {
//            return g.count
//        } else if section == 2 {
//            return ch.count
//        }
//        return 0
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // задали название контроллера назначения
//        let vc = segue.destination as! FriendsPhotoController
//        // задали название для номера строкии в таблице
//        let index = tableView.indexPathForSelectedRow?.section
//        let rowIndex = tableView.indexPathForSelectedRow?.row
//        // передаем значение из массива друзей соотвественно номера индекса в контроллер назначения
//        if index == 0 {
//            vc.friendPhoto = v[rowIndex!]
//        } else if index == 1 {
//            vc.friendPhoto = g[rowIndex!]
//        } else if index == 2 {
//            vc.friendPhoto = ch[rowIndex!]
//        }
//
//
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
//            let vName = v[indexPath.row]
//            cell.friendName.text = vName.name
//            cell.friendPhoto.image = vName.image
//            return cell
//
//        } else  if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
//            let gName = g[indexPath.row]
//            cell.friendName.text = gName.name
//            cell.friendPhoto.image = gName.image
//            return cell
//
//        } else if indexPath.section == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
//            let chName = ch[indexPath.row]
//            cell.friendName.text = chName.name
//            cell.friendPhoto.image = chName.image
//            return cell
//        }
//
//        return UITableViewCell()
//    }
   
    
}
