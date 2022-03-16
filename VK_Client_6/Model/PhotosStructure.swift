//
//  PhotosStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 18.12.2021.
//

import Foundation

// Массив данных полученных JSON
var photos = [Photo]()
var selectedImageUrls = [String]()

// MARK: - Welcome
struct PhotosConteiner: Codable {
    let response: PhotosResponse
}

// MARK: - Response
struct PhotosResponse: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
struct Photo: Codable {
    let albumID, postID, id, date: Int
    let text: String
    let sizes: [Image]
    let hasTags: Bool
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }
}

// MARK: - Size
struct Image: Codable {
    let width, height: Int
    let url: String
    let type: String
}
