//
//  Promise.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 10.02.2022.
//

import Foundation
import PromiseKit
import Alamofire
import Network
import RealmSwift

class PhotoService {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func getPhotosPromise() -> Promise<[Photo]> {
        return Promise<[Photo]> { seal in
            var urlComponents = URLComponents()
            
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/photos.getAll"
            urlComponents.queryItems = [
                URLQueryItem(name: "user_ids", value: Session.shared.userID),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            
            let url = urlComponents.url!
            let request = URLRequest(url: url)
            
            let response = session.dataTask(with: request) { data, response, error in
                if let error = error{
                    seal.reject(error)
                }
                if let data = try? Data(contentsOf: url) {
                    if let jsonContainer = try? self.decoder.decode(PhotosConteiner.self, from: data) {
                        photos = jsonContainer.response.items
                        seal.fulfill(photos)
                    }
                }
            }
            
            
        }
    }
}
