//
//  Groups_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

class GroupsR: Object, Codable {
    @objc dynamic var groupName: String
}
