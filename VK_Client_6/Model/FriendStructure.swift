//
//  FriendStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation
// Массив данных полученных из JSON
var friends = [Friend]()

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





