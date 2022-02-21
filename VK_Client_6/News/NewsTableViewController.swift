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
    
    let url: URL? = nil
    
    let dispatchGroup = DispatchGroup()

    @IBAction func singOut(_ sender: UIBarButtonItem) {
      try?  authFireBase.signOut()
        showLoginViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl()
        
        DispatchQueue.global().async(group: dispatchGroup) {
            self.urlComponents.scheme = "https"
            self.urlComponents.host = "api.vk.com"
            self.urlComponents.path = "/method/newsfeed.get"
            self.urlComponents.queryItems = [
                URLQueryItem(name: "user_ids", value: Session.shared.userID),
                //URLQueryItem(name: "order", value: "name"),
                URLQueryItem(name: "filter", value: "post, photo"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "count", value: "10"),
                URLQueryItem(name: "v", value: "5.131")
            ]
            
            let url = self.urlComponents.url!
            if let data = try? Data(contentsOf: url) {
                self.parse(json: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try?  decoder.decode(NewsContainer.self, from: json) {
            newsGroup = jsonContainer.response.groups
            newsPost = jsonContainer.response.items
            //print("NEWS GROUP")
            //print(newsGroup)
            //print(newsPost)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsPost.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarNameCell") as! AvatarNameDateCell
            let newsGroupCell = newsGroup[indexPath.row]
            let epochTime = TimeInterval(newsPost[indexPath.section].date)
            let date = Date(timeIntervalSince1970: epochTime)
            cell.date.text = "\(date)"
            cell.userName.text = newsGroupCell.name
            if let url = URL(string: newsGroupCell.photo200) {
                if let data = try? Data(contentsOf: url) {
                    cell.avatarImage.image = UIImage(data: data)
                    return cell
                }
            } 
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCell
            let info = newsPost[indexPath.section]
            cell.newsDescription.text = info.text
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            if let a = newsPost[indexPath.section].attachments {
                let b = a[0]
                if let c = b.photo?.sizes[0].url {
                    if let url = URL(string: c) {
                        if let data = try? Data(contentsOf: url) {
                            cell.newsImage.image = UIImage(data: data)
                            return cell
                        }
                    }
                }
            }
        }

        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LikesComCell") as! LikesAndCommentsCell
            if let commentsCounter = newsPost[indexPath.section].views {
                if let likesCount = newsPost[indexPath.section].likes {
                    cell.heartsCounter.text = "\(likesCount.count)"
                    cell.commentsCounter.text = "\(commentsCounter.count)"
                    return cell
                }
            }
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
    
    func refreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl?.tintColor = .brown
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    // MARK: News refreshing
    @objc func refreshNews() {
        self.refreshControl?.beginRefreshing()
        let mostFreshNewsDate = newsPost.first?.date ?? Int(Date().timeIntervalSince1970)
        newsRequest(startTime: mostFreshNewsDate)
        refreshControl?.endRefreshing()
        
    }
    
    func newsRequest(startTime: Int) {
        let checkTime = Int(Date().timeIntervalSince1970)
        if checkTime == startTime + 1 {
            // Отправляем сетевой запрос загрузки новостей
            URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data else { return }
                guard  error == nil else { return }
                
                do {
                    let jsonContainer = try JSONDecoder().decode(NewsContainer.self, from: data)
                    newsPost = jsonContainer.response.items
                } catch let error {
                    print(error)
                }
                
            }.resume()
        }
    }
}
