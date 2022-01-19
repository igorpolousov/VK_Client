//
//  Friends_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

// 1. Класс для объекта Realm
struct FriendsRContainer: Codable {
    let response: FriendsRResponse
}

struct FriendsRResponse: Codable {
    let count: Int
    let items: [FriendR]
}

class FriendR: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var photo50: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_200_orig"
        case firstName = "first_name"
    }
    
    override init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// 2.Массив с объектами класса Realm
var friendRArray = [FriendR()]

func parseRealm(json: Data) {
    let decoder = JSONDecoder()
    if let jsonContainer = try? decoder.decode(FriendsRContainer.self, from: json) {
        friendRArray = jsonContainer.response.items
        print("FRIENDS R NAME")
        print(friendRArray)
    }
}
// 3.Перевод данных в массив с объектами класса Realm
func transfer() {
    for data in friends {
        let a = FriendR()
        a.id = data.id
        a.firstName = data.firstName
        a.lastName = data.lastName
        a.photo50 = data.photo50
        friendRArray.append(a)
        for (index, friend) in friendRArray.enumerated() {
            if friend.lastName == "" && friend.firstName == "" {
                friendRArray.remove(at: index)
            }
        }
    }
    print("FRIEND R ARRAY")
    print(friendRArray)
}

// 4. Добавление массива с объектами Realm в базу данных
func addToRealmDataBase() {
    let realmData = List<FriendR>()
    for friendR in friendRArray {
        realmData.append(friendR)
    }
    do {
        let realm = try Realm()
        realm.beginWrite()
        let friendsFromRealm = realm.objects(FriendR.self)
        realm.delete(friendsFromRealm)
        realm.add(realmData)
        try realm.commitWrite()
        print("REALM DATA")
        print(realm.configuration.fileURL as Any)
    } catch {
        print(error)
    }
    print("REALM DATA")
    print(realmData)
}

// 5. Получение данных для таблицы
func getDataFromRealm() -> Results<FriendR> {
    var observerArray: Results<FriendR>!
    do {
        let realm = try Realm()
        let realmObserver = realm.objects(FriendR.self)
        observerArray = realmObserver
        let getRealmData = Array(realm.objects(FriendR.self))
        for data in getRealmData {
            var friendTable = FriendTable(firstName: "", lastName: "", photo50: "")
            friendTable.firstName = data.firstName
            friendTable.lastName = data.lastName
            friendTable.photo50 = data.photo50
            friendsName.append(friendTable)
        }
    } catch {
        print(error)
    }
    print("FRIENDS NAME")
    print(friendsName)
    return observerArray
}

// 6 Перевод данных из Realm в данные для таблицы
func fromRealmToTable(_ array: Results<FriendR>) -> [FriendTable] {
    for data in array {
        var a = FriendTable(firstName: "", lastName: "", photo50: "")
        a.firstName = data.firstName
        a.lastName = data.lastName
        a.photo50 = data.photo50
        
    }
    return  friendsName
}
