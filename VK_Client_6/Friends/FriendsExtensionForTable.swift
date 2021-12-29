//
//  FriendsExtensionForTable.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 23.12.2021.
//

import Foundation
import RealmSwift

// 1. структура для отображения данных в таблице
struct FriendForTable {
    var sectionName: String
    var sectionObjects: [FriendTable]
}

struct FriendTable: Equatable {
    var firstName: String
    var lastName: String
    var photo50: String
    
    static func == (lhs: FriendTable, rhs: FriendTable) -> Bool{
        return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
}

// 2. Массив с данными
var letters = ["а","б","в","г","д","е","ж","з","и","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","э","ю","я","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

// Начальный массив с именами
var friendsName = [FriendTable]()


//var friendForTableArray = [FriendForTable]()


func convertedNames(_ names: [FriendTable]) -> [FriendForTable] {
    // Чтобы данные в таблице обновлялись возращаемый массив должен быть локальной переменной внутри функции
    var objectsArray = [FriendForTable]()
    var nameDict = Dictionary<String, Array<FriendTable>>()
    
    for letter in letters {
        for name in names {
            if letter.uppercased() == name.lastName.first?.uppercased() {
                nameDict[letter] = [name]
            }
        }
    }
    
    for name in names {
        for letter in letters {
            if letter.uppercased() == name.lastName.first?.uppercased() {
                if let a = nameDict[letter] {
                    if !a.contains(name) {
                        nameDict[letter]?.append(name)
                    }
                }
            }
        }
    }
    
    let sortedDict = nameDict.sorted { $0.key.localizedCaseInsensitiveCompare($1.key) == ComparisonResult.orderedAscending }
    
    for (key,value) in sortedDict {
        objectsArray.append(FriendForTable(sectionName: key, sectionObjects: value))
    }
    return objectsArray
}

var sortedFriends = convertedNames(friendsName)


  
