//
//  FriendsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    
    var urlComponents = URLComponents()
    let session = URLSession.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromRealm()
        convertedNames()
        
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
            print("FRIENDS NAME")
            print(friendsName)
            addToRealmDataBase()
            return
        }
     
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(FriendsContainer.self, from: json) {
            friends = jsonContainer.response.items
            print(friends)
            transfer()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        friendForTableArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if friendForTableArray[section].sectionObjects.isEmpty{
            return nil
        } else {
            return friendForTableArray[section].sectionName.uppercased()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendForTableArray[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        let section = friendForTableArray[indexPath.section]
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
            vc.friendPhoto = friendForTableArray[indexPath.section].sectionObjects[indexPath.row].photo50
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! FriendsPhotoController
//        let section = tableView.indexPathForSelectedRow?.section
//        let rowIndex = tableView.indexPathForSelectedRow?.row
//        vc.friendPhoto = friendForTableArray[section!].sectionObjects[rowIndex].photo50
//    }
    
}


