//
//  NewsTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import Firebase

class NewsTableViewController: UITableViewController {
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        try? authFireBase.signOut()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AppLoginView") {
            if let window = self.view.window {
                window.rootViewController = vc
            }
        }
    }
    

    let authFireBase = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "App LogOut", style: .plain, target: self, action: #selector(backToLoginView))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
//    @objc func backToLoginView() {
//       try? authFireBase.signOut()
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AppLoginView") else { return }
//        if let window = self.view.window {
//            window.rootViewController = vc
//        }
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        let info = news[indexPath.row]
        cell.date.text = info.newsDate
        cell.friendImage.image = info.userImage
        cell.friendName.text = info.userName
        cell.newsImage.image = info.newsImage
        cell.newsText.text = info.newsText

        return cell
    }
}
