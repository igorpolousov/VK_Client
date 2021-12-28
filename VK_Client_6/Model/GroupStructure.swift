//
//  GroupStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation

// Массив данных полученных JSON
var  myGroups = [Group]()

struct GroupContainer: Codable {
    let response: GroupResponse
}

// MARK: - Response
struct GroupResponse: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}
//import UIKit
//
//struct Group {
//    var groupName: String
//    var groupImage: UIImage
//}
//
//extension Group: Equatable {
//    static func == (lhs: Group, rhs: Group) -> Bool{
//        return lhs.groupName == rhs.groupName &&
//            lhs.groupImage == rhs.groupImage
//    }
//}
