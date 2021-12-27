//
//  GroupsSearch.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation


// MARK: - Welcome
struct GroupsSearchContainer: Codable {
    let response: GroupsSearchResponse
}

// MARK: - Response
struct GroupsSearchResponse: Codable {
    let count: Int
    let items: [GroupSearch]
}

// MARK: - Item
struct GroupSearch: Codable {
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
