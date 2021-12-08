//
//  GroupStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation
import UIKit

struct Group {
    var groupName: String
    var groupImage: UIImage
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool{
        return lhs.groupName == rhs.groupName &&
            lhs.groupImage == rhs.groupImage
    }
}
