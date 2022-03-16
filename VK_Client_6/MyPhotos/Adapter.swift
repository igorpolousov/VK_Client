//
//  Adapter.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 16.03.2022.
//

import Foundation


protocol PhotoAdapter {
    func photoadapter(method: String) -> [Photo]
}


class Adapter: PhotoAdapter {
    var urlComponents = URLComponents()
    let session = URLSession.shared
    
    static let data = Adapter()
    init() {}
    
    func photoadapter(method: String) -> [Photo] {
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/\(method)"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: Session.shared.userID),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        let url = urlComponents.url!
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonContainer = try? decoder.decode(PhotosConteiner.self, from: data) {
                photos = jsonContainer.response.items
            }
        }
        return photos
    }
   
}
