//
//  Friends_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

class FriendR: Object, Codable {
    @objc dynamic var lastName: String
    @objc dynamic var firstName: String
    @objc dynamic var photo50: String
    
}


