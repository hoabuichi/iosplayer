//
//  EventModel.swift
//  ONEdu
//
//  Created by Tran Dat on 04/06/2022.
//

import Foundation

enum TypeEventBlock: Int {
    case category = 1
    case channel = 2
    case series = 3
    case live = 4
}

class EventModel: CoreObject {
    var id: Int = 0
    var name: String = ""
    var type: TypeEventBlock = .category
    var thumbnail: String = ""

    init (id: Int, name: String, type: TypeEventBlock, thumbnail: String) {
        self.id = id
        self.name = name
        self.type = type
        self.thumbnail = thumbnail
    }
    
    required init(data: [AnyHashable : Any]?) {
//        if let idTemp = data?["id"] as? Int {
//            id = idTemp
//        }
//
//        if let nameTemp = data?["name"] as? String {
//            name = nameTemp
//        }
//
//        if let thumbnailTemp = data?["thumb"] as? String {
//            thumbnail = thumbnailTemp
//        }
//
//        if let _type = data?["game_type_id"] as? Int {
//            if let newType = TypeMiniGame(rawValue: _type) {
//                type = newType
//            }
//        }
    }
}

class HomeModel: CoreObject {
    var id: Int = 0
    var nameBLock: String = ""
    var logo: String = ""
    var type: TypeEventBlock = .series
    var listEvent: [EventModel] = []

    init(id: Int, nameBLock: String, listEvent: [EventModel], logo: String, type: TypeEventBlock) {
        self.id = id
        self.nameBLock = nameBLock
        self.listEvent = listEvent
        self.logo = logo
        self.type = type
    }
    
    required init(data: [AnyHashable : Any]?) {
//        if let idTemp = data?["id"] as? Int {
//            id = idTemp
//        }
//
//        if let nameTemp = data?["name"] as? String {
//            nameBLock = nameTemp
//        }
//
//        if let listGamesTemp = data?["list_mini_game"] as? [[AnyHashable : Any]] {
//            listGames = listGamesTemp.map({GameModel(data: $0)})
//        }
    }
}
