//
//  FriendStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation
import UIKit

struct Friend {
    var name: String
    var image: UIImage
    var pic: [UIImage]
}


var friends = [
    Friend(name: "Крокодил Гена", image: UIImage.init(imageLiteralResourceName: "gena"),pic: [UIImage.init(imageLiteralResourceName: "gena1"), UIImage.init(imageLiteralResourceName: "gena2")]),
    Friend(name: "Винни Пух", image: .init(imageLiteralResourceName: "vinni"),pic: [UIImage.init(imageLiteralResourceName: "vinni1"),UIImage.init(imageLiteralResourceName: "vinni2")]),
    Friend(name: "Чебурашка Знатный", image: .init(imageLiteralResourceName: "chebu"),pic: [UIImage.init(imageLiteralResourceName: "chebu1"), UIImage.init(imageLiteralResourceName: "chebu2"), .init(imageLiteralResourceName: "chebu3")])
]

let g = friends.filter({$0.name.contains("Г")})
let v = friends.filter({$0.name.contains("В")})
let ch = friends.filter({$0.name.contains("Ч")})



let nameArray = [g, v, ch]


