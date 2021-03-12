//
//  ServerData.swift
//  PryanikyTest
//
//  Created by Egor on 11.03.2021.
//

import Foundation

enum ServerDataItemType: String, Codable {
    case hz, picture, selector
}

struct ServerResponseData: Codable {
    var data: [ServerDataItem]
    var view: [String]
}

struct ServerDataItem: Codable {
    var name: ServerDataItemType
    var data: ServerData
}

struct ServerData: Codable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedId, variants
    }
}

struct Variant: Codable {
    var id: Int
    var text: String
}
