//
//  Session.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 12.04.2021.
//

import Foundation

// Class session
class Session {
    static let shared = Session()
    
    private init() {}
    
    // Properties
    var token = ""
    var userID = ""
    
}
