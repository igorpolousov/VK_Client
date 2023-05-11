//
//  PhotosViewController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 18.12.2021.
//

import UIKit
import RealmSwift
import PromiseKit

class PhotosViewController: UITableViewController {
    
//    var urlComponents = URLComponents()
//    let session = URLSession.shared
    let adapter = Adapter()
    
    
    var photosObserver: Results<PhotosR>?
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = adapter.photoadapter(method: "photos.getAll")
        
        photosObserver = getPhotosDataFromRealm()
        //print("PHOTOS OBSERVER \(photosObserver)")
        
        self.token = self.photosObserver?.observe(on: .main, { [weak self] (changes: RealmCollectionChange) in
            self?.photosObserver = getPhotosDataFromRealm()
            photosFromRealmToTable((self?.photosObserver!)!)
            self?.tableView.reloadData()
        })
        
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/photos.getAll"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "user_ids", value: Session.shared.userID),
//            URLQueryItem(name: "access_token", value: Session.shared.token),
//            URLQueryItem(name: "v", value: "5.131")
//        ]
//
//        let url = urlComponents.url!
//        if let data = try? Data(contentsOf: url) {
//            self.parse(json: data)
//            print("PHOTOS \(photos)")
//            addPhotosToRealmDataBase()
//        }
//    }
//
//    func parse(json: Data) {
//        let decoder = JSONDecoder()
//        if let jsonContainer = try? decoder.decode(PhotosConteiner.self, from: json) {
//            photos = jsonContainer.response.items
//           transferPhotos()
//        }
    }

    // MARK: Table data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("PHOTOS FOR TABLE \(photosForTable)")
        return photosForTable.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPhotoMy", for: indexPath) as! MyPhotosTableViewCell
        
        let url = photosForTable[indexPath.row]
        
        cell.imageTitle.text = "Image title"
        
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                cell.imagePhotoLoad.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Myphotos") as? MyPhotosViewController {
            let url = photosForTable[indexPath.row]
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    let imageToSend = UIImage(data: data)
                    vc.imageGet = imageToSend
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        } 
    }

}
