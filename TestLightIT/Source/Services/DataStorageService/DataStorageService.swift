//
//  DataStorageService.swift
//  TestLightIT
//
//  Created by Анна Яцун on 07.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation
import RealmSwift


class DataStorageService<T: RealmObject<PlainObject>, PlainObject: Codable> {

    private(set) var realm: Realm?

    init(objectType: T.Type) {
        do {
            var config = Realm.Configuration(objectTypes: [objectType])
            let fileName = "defaultUser_\(T.description()).realm"
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
            self.realm = try Realm(configuration: config)
        } catch let error {
            print(error.localizedDescription)
            self.realm = nil
        }
    }

    init(objects: [Object.Type]) {
        do {
            var config = Realm.Configuration(objectTypes: objects)
            let fileName = "defaultUser_\(T.description()).realm"
            config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent(fileName)
            self.realm = try Realm.init(configuration: config)
        } catch let error {
            print(error.localizedDescription)
            self.realm = nil
        }

    }

    func saveItems(_ items: [PlainObject]) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        let realmObjects = items.map { item -> T in
                            let realmObject = T.init()
                            realmObject.plainObject = item

                            return realmObject
                        }

                        realm.add(realmObjects)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func loadItems(_ completion: @escaping ([PlainObject]) -> Void) {
        var items: Results<T>?
        DispatchQueue.main.async {
            items = self.realm?.objects(T.self)
            completion(items?.compactMap { $0.plainObject } ?? [])
        }
    }

    func deleteItems() {
        if let realm = self.realm {
            DispatchQueue.main.async {
                do {
                    let items = realm.objects(T.self)
                    try realm.write {
                        realm.delete(items)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

class RealmObject<T: Codable>: Object {

    @objc private dynamic var structData: Data?

    var plainObject: T? {
        get {
            var result: T?
            if let data = structData {
                do {
                    result = try JSONDecoder().decode(T.self, from: data)
                } catch(let error) {
                    print(error)
                }
            }

            return result
        }
        set {
            do {
                structData = try JSONEncoder().encode(newValue)
            } catch(let error) {
                print(error)
            }
        }
    }

    override static func ignoredProperties() -> [String] {
        return ["plainObject"]
    }
}


class RealmComments: RealmObject<[CommentsModel]> {

    @objc dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}

extension DataStorageService where PlainObject == [CommentsModel]  {

    func saveProductComments(items: [CommentsModel], product id: String) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        let object = RealmComments()
                        object.plainObject = items
                        object.id = id
                        
                        realm.create(RealmComments.self, value: object, update: .modified)
                    }
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    func loadAlbums(id: String, _ completion: @escaping ([CommentsModel]) -> Void) {
        DispatchQueue.main.async {
            let item = self.realm?.object(ofType: RealmComments.self, forPrimaryKey: id)
            let albums = item?.plainObject ?? []
            
            completion(albums)
        }
    }
    
    func deleteAlbums(id: String) {
        DispatchQueue.main.async {
            if let realm = self.realm {
                do {
                    try realm.write {
                        if let object = realm.object(ofType: RealmComments.self, forPrimaryKey: id) {
                            realm.delete(object)
                        }
                    }
                } catch (let error) {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}
