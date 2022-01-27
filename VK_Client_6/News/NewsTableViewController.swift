//
//  NewsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import Firebase

class NewsTableViewController: UITableViewController {
    let authFireBase = Auth.auth()
    
    var urlComponents = URLComponents()
    let session = URLSession.shared

    @IBAction func singOut(_ sender: UIBarButtonItem) {
      try?  authFireBase.signOut()
        showLoginViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            //URLQueryItem(name: "order", value: "name"),
            //URLQueryItem(name: "filter", value: "post"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
 
        let url = urlComponents.url!
        if let data = try? Data(contentsOf: url) {
            print("DATA NEWS")
            print(data)
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, urlResponse, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            print(String(decoding: jsonData!, as: UTF8.self))
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarNameCell") as! AvatarNameDateCell
            cell.date.text = news[indexPath.section].newsDate
            cell.userName.text = news[indexPath.section].userName
            cell.avatarImage.image = news[indexPath.section].userImage
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCell
            let info = news[indexPath.section]
            cell.newsDescription.text = info.newsText
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.newsImage.image = news[indexPath.section].newsImage
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikesComCell") as! LikesAndCommentsCell
            return cell
        }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
//
//        let info = news[indexPath.row]
//        cell.date.text = info.newsDate
//        cell.friendImage.image = info.userImage
//        cell.friendName.text = info.userName
//        cell.newsImage.image = info.newsImage
//        cell.newsText.text = info.newsText

        return UITableViewCell()
    }
    
    func showLoginViewController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AppLoginView") as? LoginFormController {
            if let window = self.view.window {
                window.rootViewController = vc
            }
        }
    }
}
