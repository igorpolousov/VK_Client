//
//  HashImageTableControllerTableViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 11.02.2022.
//

import UIKit

class HashImageTableControllerTableViewController: UITableViewController {
    
    var urlComponents = URLComponents()
    
    var photoService: PhotoService?
    var dateFormatter: DateFormatter?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.register(UINib(nibName: "HashCell", bundle: nil), forCellReuseIdentifier: "MyHashCell")
        
        photoService = PhotoService(container: self.tableView)
       
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let url = urlComponents.url!
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
        }
    }
        
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(PhotosConteiner.self, from: json) {
            photos = jsonContainer.response.items
            for photo in photos {
                let a = photo.sizes
                for image in a {
                    if image.type == "q" {
                        selectedImageUrls.append(image.url)
                        
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHashCell", for: indexPath) as! HashCell
        let photo = photos[indexPath.row]
        let url = selectedImageUrls[indexPath.row]
    
        dateFormatter?.dateFormat = "dd.MM.yyyy HH.mm"
        let date = Date(timeIntervalSince1970: TimeInterval(photo.date))
        
//        cell.textLabel?.text = "\(date)"
//        cell.imageView?.image = photoService!.photo(byUrl: url)
        
        cell.hashCellDateLabel.text = "\(date)"
        cell.hashCellImage.image = photoService!.photo(byUrl: url)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "HashImage") as? HashBigImageViewController {
            let url = selectedImageUrls[indexPath.row]
            let image = photoService!.photo(byUrl: url)
            vc.imageGet = image
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}
