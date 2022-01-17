//
//  Groups_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift


// 1. Класс для объекта Realm
class GroupR: Object, Codable {
    override init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        }
    @objc dynamic var id: Int = 0
    @objc dynamic var groupName: String = ""
    @objc dynamic var photo: String = ""
    override static func primaryKey() -> String? {
            return "id"
        }
}

// 2. Массив для объектов Realm
var groupRArray = [GroupR]()

// 3. Перевод данных в массив с объектами класса Realm
func transferGroup() {
    for group in myGroups {
        let groupR = GroupR()
        groupR.id = group.id
        groupR.groupName = group.name
        groupR.photo = group.photo200
        groupRArray.append(groupR)
    }
}

// 4. Добавление массива с объектами Realm в базу данных
func addGroupsToRealmDataBase() {
    // Массив групп для Realm
    let realmGroupsData = List<GroupR>()
    // Добавляем группы в массив Realm
    for groupR in groupRArray {
        realmGroupsData.append(groupR)
    }
    do {
        let realm = try Realm()
        realm.beginWrite()
        let groupsFromRealm = realm.objects(GroupR.self)
        realm.delete(groupsFromRealm)
        realm.add(realmGroupsData)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}


// Структура для таблицы
struct GroupT {
    var groupName: String
    var photoUrl: String
}
// Массив для таблицы

// 5. Получение данных для таблицы
func getGroupsDataFromRealm() -> Results<GroupR> {
    var observerArray: Results<GroupR>!
    do {
        let realm = try Realm()
        let realmObserver = realm.objects(GroupR.self)
        observerArray = realmObserver
//        let getDataFromRealm = Array(realm.objects(GroupR.self))
//        for data in getDataFromRealm {
//            var groupT = GroupT(groupName: "", photoUrl: "")
//            groupT.groupName = data.groupName
//            groupT.photoUrl = data.photo
//            groupsTable.append(groupT)
//        }
        
    } catch {
        print(error)
    }
    return observerArray
}

// 6. Перевод данных из Realm в данные таблицы
func groupsFromRealmToTable(_ array: Results<GroupR>) -> [GroupT] {
    var groupsTable = [GroupT]()
    for data in array {
        var a = GroupT(groupName: "", photoUrl: "")
        a.groupName = data.groupName
        a.photoUrl = data.photo
        groupsTable.append(a)
    }
    return groupsTable
}


