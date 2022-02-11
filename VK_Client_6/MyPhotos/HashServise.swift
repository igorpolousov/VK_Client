//
//  HashServise.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 11.02.2022.
//

import UIKit
import Alamofire

class PhotoService {
    
   // задали константу, она будет определять время в секундах, в течение которого кеш считается актуальным. Обратите внимание на стиль, которым она задана. Это умножение чисел — дней, часов, минут и секунд.
    // MARK: Задано время хранения файлов в папке
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    // MARK: Путь к папке и имя папки куда будут сохраняться изображения
    private static let pathName: String = {
        
//        cтатическое свойство, имя папки, в которой будут сохраняться изображения. Свойство инициируется с помощью замыкания. Помимо этого, в замыкании происходит проверка, существует ли папка. Если не существует, она будет создана.
        let pathName = "images"
        
        // Указали путь к папке CashDirectory
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        // Добавили папку(путь к папке) с именем pathName
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        // Сделали проверку на наличие такой папки, если такой папки не существует создали папку по указанному пути
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        // Вернули название папки
        return pathName
    }()
    
//     получает на вход URL изображения и возвращает на его основе путь к файлу для сохранения или загрузки. Имя для файла мы получаем на основе его URL, который чаще всего будет ссылкой на этот файл в сети Internet. Таким образом, имя файла будет совпадать с тем, что на сервере.
    // MARK: Получаем путь к файлу
    private func getFilePath(url: String) -> String? {
        // Сделали проверку что директория существует
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        // Задали получение имени файлов
        let hashName = url.split(separator: "/").last ?? "default"
        // Вернули путь к файлу
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
   // MARK: сохраняет изображение в файловой системе
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
        let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
//    загружает изображение из файловой системы. При этом он проводит ряд проверок. Первым делом мы пытаемся получить атрибуты изображения FileManager.default.attributesOfItem. Этот метод вернёт всю техническую информацию о файле, если он существует. Нас интересует дата последнего изменения. Если со времени изменения файла прошло больше секунд, чем указано в нашем свойстве cacheLifeTime, файл считается устаревшем и мы не будем заново загружать его из сети.
    // MARK: Получение файла из папки по указанному пути
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            // Проверяем что имя фала существует
            let fileName = getFilePath(url: url),
            // Получаем данные по свойству файла
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            // Получаем дату создания файла
             let modificationDate = info[FileAttributeKey.modificationDate] as? Date
             else { return nil }
         
        // Получаем время прошедшее после создания файла
         let lifeTime = Date().timeIntervalSince(modificationDate)
         
         guard
            // Делаем проверку путем сравнения времени с момента создания файла и заданного времени зранения файла
             lifeTime <= cacheLifeTime,
             // Если файл хранился меньше заданного времени, то берем файл из папки
             let image = UIImage(contentsOfFile: fileName) else { return nil }

         DispatchQueue.main.async {
            self.images[url] = image
         }
        // Возвращаем картинку из папки
         return image
     }

//словарь в котором будут храниться загруженные и извлеченные из файловой системы изображения. Это кеш в оперативной памяти с минимальным временем доступа, специально для таблиц и коллекций, где очень важна скорость получения изображений
    //MARK: словарь для хранения изображений
     private var images = [String: UIImage]()
     
//    загружает фото из сети. Это обычный Alamofire-запрос на получение данных, он проходит в глобальной очереди, загружает изображение, сохраняет его на диске и в словаре images. Кроме того, после окончания загрузки он обновляет строку в таблице, чтобы отобразить загруженное изображение.
    //MARK: загрузка изображений из сети  !Переписать без alamofire
     private func loadPhoto(atIndexpath indexPath: IndexPath?, byUrl url: String) {
        
         // Получение данных изображения в глобальном потоке
         AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
             guard
                 let data = response.data,
                 let image = UIImage(data: data) else { return }
             // Добавили картинку в словарь
             DispatchQueue.main.async {
                 self?.images[url] = image
             }
             // Сохранили картинку в папку
             self?.saveImageToCache(url: url, image: image)
             // Перезагрузка строки в таблице ??Нафиг это надо??
             DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath!)
             }
             
         }
     }

//Метод photo предоставляет изображение по URL. При этом мы ищем изображение сначала в кеше оперативной памяти, потом в файловой системе; если его нигде нет, загружаем из сети. IndexPath требуется, чтобы установить загруженное изображение в нужной строке, а не в ячейке, которая в момент, когда загрузка завершится, может быть использована для совершенно другой строки.
     func photo(atIndexpath indexPath: IndexPath?, byUrl url: String) -> UIImage? {

         var image: UIImage?
         if let photo = images[url] {
             image = photo
         } else if let photo = getImageFromCache(url: url) {
             image = photo
         } else {
            loadPhoto(atIndexpath: nil, byUrl: url)
         }
         return image
     }
     
    private let container: DataReloadable
       
       init(container: UITableView) {
           self.container = Table(table: container)
       }
       
       init(container: UICollectionView) {
           self.container = Collection(collection: container)
       }
       
//           Для перезагрузки необходима ссылка на объект таблицы или коллекции, и здесь нас подстерегает первая сложность: у таблицы и коллекции разные классы и методы обновления элемента. Для унифицирования обновления мы создадим протокол и два объекта, в которые обернём коллекцию и таблицу.
   }

   fileprivate protocol DataReloadable {
       func reloadRow(atIndexpath indexPath: IndexPath)
   }

   extension PhotoService {
  
//    Table — первый класс, имплементирующий протокол DataReloadable. В него будет заворачиваться UITableView. Есть свойство для хранения ссылки на таблицу и конструктор, принимающий эту таблицу. Самое важное — реализация метода reloadRow, он вызывает обновление строки в таблице.
       private class Table: DataReloadable {
           let table: UITableView
           
           init(table: UITableView) {
               self.table = table
           }
           
           func reloadRow(atIndexpath indexPath: IndexPath) {
               table.reloadRows(at: [indexPath], with: .none)
           }
           
       }
    
//       Класс Collection аналогичен классу Table, с той лишь разницей, что он хранит ссылку на экземпляр UICollectioView и обновляет её элементы.
       private class Collection: DataReloadable {
           let collection: UICollectionView
           
           init(collection: UICollectionView) {
               self.collection = collection
           }
           
           func reloadRow(atIndexpath indexPath: IndexPath) {
               collection.reloadItems(at: [indexPath])
           }
       }
   }
