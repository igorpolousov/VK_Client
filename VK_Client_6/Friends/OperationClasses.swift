//
//  OperationsClasses.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 03.02.2022.
//

import Foundation


class GetDataOperation: Operation {
    var urlComponents = URLComponents()
    var data = Data()
    var url = URLComponents().url
    
    override func main() {
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
        
        url = urlComponents.url
        data = try! Data(contentsOf: url!)
    }
    
    init(url: URL) {
        self.url = url
    }
    
}

class ParseOperation: Operation {
    
    let decoder = JSONDecoder()
    var dataArray = [Friend]()
    var friendRArray = [FriendR()]
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation else { return }
         let data = getDataOperation.data
            let jsonContainer = try? decoder.decode(FriendsContainer.self, from: data)
        dataArray = jsonContainer?.response.items ?? [Friend]()
        friends = dataArray
              transfer()
    }
    
}

class AddToRealmOperation: Operation {
    
    override func main() {
        guard let parseData = dependencies.first as? ParseOperation else { return }
        //let friendRArray = parseData.friendRArray
        addToRealmDataBase()
    }
}
