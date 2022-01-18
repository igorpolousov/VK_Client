//
//  FireBase.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 17.01.2022.
//

import Foundation
import Firebase

class FireBase {
    let iserId: String
    let groupAdded: String
    let ref: DatabaseReference?
    
    init(userId: String, groupAdded: String) {
        self.ref = nil
        self.groupAdded = groupAdded
        self.iserId = userId
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let userId = value["userId"] as? String,
            let groupAdded = value["groupAdded"] as? String else {
                return nil
            }
        
        self.ref = snapshot.ref
        self.groupAdded = groupAdded
        self.iserId = userId
        
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "userId": iserId,
            "groupAdded": groupAdded
        ]
    }
}

