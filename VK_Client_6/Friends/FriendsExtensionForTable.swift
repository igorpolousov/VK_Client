//
//  FriendsExtensionForTable.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 23.12.2021.
//

import Foundation
import RealmSwift

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

var letters = ["а","б","в","г","д","е","ж","з","и","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","э","ю","я","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

var nameDict = Dictionary<String, Array<FriendTable>>()
var friendsName = [FriendTable]()
var sortedFriendsName = [FriendTable]()
var friendForTableArray = [FriendForTable]()


extension FriendsTableViewController {
    
//    func addFriendForTable() {
//        for friend in friends {
//            friendForTable.lastName = friend.lastName
//            friendForTable.firstName = friend.firstName
//            friendForTable.photo50 = friend.photo50
//            friendsName.append(friendForTable)
//        }
//        print("Friends NAMe \(friendsName)")
//    }
    
    func convertedNames() {
        let sortedFriendsName = friendsName.sorted { $0.lastName.localizedCaseInsensitiveCompare($1.lastName) == ComparisonResult.orderedAscending }
        
        for letter in letters {
            for friend in sortedFriendsName {
                if letter.uppercased() == friend.lastName.first?.uppercased() {
                    nameDict[letter] = [friend]
                }
            }
        }
        
        for friend in sortedFriendsName {
            for letter in letters {
                if letter.uppercased() == friend.lastName.first?.uppercased() {
                    if let a = nameDict[letter] {
                        if !a.contains(friend) {
                            nameDict[letter]?.append(friend)
                        }
                    }
                }
            }
        }
        
        let sortedDict = nameDict.sorted { $0.key.localizedCaseInsensitiveCompare($1.key) == ComparisonResult.orderedAscending }
        
        for (key,value) in sortedDict {
            friendForTableArray.append(FriendForTable(sectionName: key, sectionObjects: value))
        }
        
    }
  
}
