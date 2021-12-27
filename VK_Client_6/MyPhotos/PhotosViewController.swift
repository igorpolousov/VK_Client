//
//  PhotosViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 18.12.2021.
//

import UIKit

class PhotosViewController: UITableViewController {
    
    var photos = [Photo]()
    var photosR = PhotosR()
    var photosRArray = [PhotosR]()
    
    var urlComponents = URLComponents()
    let session = URLSession.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            saveAppData(data: photosRArray )
            return
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonContainer = try? decoder.decode(PhotosConteiner.self, from: json) {
            photos = jsonContainer.response.items
            for photo in photos {
                let images = photo.sizes
                for image in images {
                    photosR.imageURL = image.url
                    photosRArray.append(photosR)
                }
            }
           
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPhotoMy", for: indexPath)
        let photo = photos[indexPath.row].sizes
        let images = photo[indexPath.row].url
  
            if let url = URL(string: images ) {
                if let data = try? Data(contentsOf: url) {
                    cell.imageView?.image = UIImage(data: data)
                }
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Myphotos") as? MyPhotosViewController {
            let photo = photos[indexPath.row].sizes
            let images = photo[indexPath.row].url
            if let url = URL(string: images ) {
                if let data = try? Data(contentsOf: url) {
                    let imageToSend = UIImage(data: data)
                    vc.imageGet = imageToSend
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        } 
    }

}