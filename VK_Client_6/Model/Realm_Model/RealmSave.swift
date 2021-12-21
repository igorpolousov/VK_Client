//
//  RealmSave.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift

func saveAppData(data: [Object]) {
    do {
        // Получили доступ к хранилищу
        let realm = try Realm()
        // начало изменения данных
        realm.beginWrite()
        // кладём все нужные объекты в хранилище
        realm.add(data)
        // завершаем изменение хранилища
        try realm.commitWrite()
        
    } catch {
        print("Can't save data")
    }
}
