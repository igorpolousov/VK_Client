//
//  Friends_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

// 1. Класс для объекта Realm
class FriendR: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var photo50: String = ""
}

// 2.Массив с объектами класса Realm
var friendRArray = [FriendR()]



// 3.Перевод данных в массив с объектами класса Realm
func transfer() {
    for (index,data) in friends.enumerated() {
        let a = FriendR()
        a.id = index
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
        print(realm.configuration.fileURL)
    } catch {
        print(error)
    }
    print("REALM DATA")
    print(realmData)
}

// 5. Получение данных для таблицы
func getDataFromRealm() {
    do {
        let realm = try Realm()
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
}
