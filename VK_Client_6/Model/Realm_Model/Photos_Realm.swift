//
//  Photos_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

class PhotosR: Object, Codable {
    @objc dynamic var imageURL: String
}
