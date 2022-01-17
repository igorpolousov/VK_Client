//
//  Photos_Realm.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 21.12.2021.
//

import Foundation
import RealmSwift


// 1. Класс для объекта Realm
class PhotosR: Object, Codable {
    override init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        }
    @objc dynamic var id: Int = 0
    @objc dynamic var imageURL: String = ""
    override static func primaryKey() -> String? {
            return "id"
        }
}

// 2. Массив для объектов Realm
var photosRArray = [PhotosR]()

// 3. Перевод данных в массив с объектами класса Realm
func transferPhotos() {
    for (index,photo) in photos.enumerated() {
        let images = photo.sizes
        let photosR = PhotosR()
        for image in images {
            photosR.id = index
            photosR.imageURL = image.url
            photosRArray.append(photosR)
        }
    }
}

// 4. Добавление массива с объектами Realm в базу данных
func addPhotosToRealmDataBase() {
    let realmPhotoData = List<PhotosR>()
    for photoR in photosRArray {
        realmPhotoData.append(photoR)
    }
    
    do {
        let realm = try Realm()
        realm.beginWrite()
        let photosFromRealm = realm.objects(PhotosR.self)
        realm.delete(photosFromRealm)
        realm.add(realmPhotoData)
        try realm.commitWrite()
    } catch {
        print(error)
    }
}

// Массив для таблицы
var photosForTable = [String]()

// 5. Получение данных для таблицы
func getPhotosDataFromRealm() -> Results<PhotosR>  {
    var observerArray: Results<PhotosR>!
    do {
        let realm = try Realm()
        let realmObserver = realm.objects(PhotosR.self)
        observerArray = realmObserver
    } catch {
        print(error)
    }
    return observerArray
}

// 6. Перевод данных из Realm в данные таблицы
func photosFromRealmToTable(_ array: Results<PhotosR>) {
    photosForTable.removeAll()
    for data in array {
        let photoURL = data.imageURL
        photosForTable.append(photoURL)
    }
}
