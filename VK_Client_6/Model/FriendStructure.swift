//
//  FriendStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation


// MARK: - Welcome
struct FriendsContainer: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let canAccessClosed: Bool
    let city: City
    let id: Int
    let lastName: String
    let photo50: String
    let trackCode: String
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case city, id
        case lastName = "last_name"
        case photo50 = "photo_200_orig"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}


//import UIKit
//
//struct Friend {
//    var name: String
//    var image: UIImage
//    var pic: [UIImage]
//}
//
//
//var friends = [
//    Friend(name: "Крокодил Гена", image: UIImage.init(imageLiteralResourceName: "gena"),pic: [UIImage.init(imageLiteralResourceName: "gena1"), UIImage.init(imageLiteralResourceName: "gena2")]),
//    Friend(name: "Винни Пух", image: .init(imageLiteralResourceName: "vinni"),pic: [UIImage.init(imageLiteralResourceName: "vinni1"),UIImage.init(imageLiteralResourceName: "vinni2")]),
//    Friend(name: "Чебурашка Знатный", image: .init(imageLiteralResourceName: "chebu"),pic: [UIImage.init(imageLiteralResourceName: "chebu1"), UIImage.init(imageLiteralResourceName: "chebu2"), .init(imageLiteralResourceName: "chebu3")])
//]
//
//let g = friends.filter({$0.name.contains("Г")})
//let v = friends.filter({$0.name.contains("В")})
//let ch = friends.filter({$0.name.contains("Ч")})
//
//
//
//let nameArray = [g, v, ch]


