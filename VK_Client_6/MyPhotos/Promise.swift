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

class PhotoService {

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
            
            AF.request(url).responseJSON { response in
                if let error = response.error {
                    seal.reject(error)
                }
                if let data = response.data {
                    do {
                        let jsonContainer = try JSONDecoder().decode(PhotosConteiner.self, from: data)
                        photos = jsonContainer.response.items
                        seal.fulfill(photos)
                    } catch {
                        seal.reject("no photos" as! Error)
                    }
                }
            }
            
            
        }
    }
}
