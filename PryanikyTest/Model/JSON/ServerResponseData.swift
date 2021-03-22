//
//  ServerData.swift
//  PryanikyTest
//
//  Created by Egor on 11.03.2021.
//

import Foundation

struct ServerResponseData: Codable {
    var data: [ServerDataItem]
    var view: [String]
}

struct ServerDataItem: Codable {
    var name: String
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

extension ServerData {

    init(from decoder: Decoder) throws {

        let values = try? decoder.container(keyedBy: CodingKeys.self)

        text = try? values?.decode(String.self, forKey: .text)
        url = try? values?.decode(String.self, forKey: .url)
        selectedId = try? values?.decode(Int.self, forKey: .selectedId)
        variants = try? values?.decode([Variant].self, forKey: .variants)
    }
}

struct Variant: Codable {
    var id: Int
    var text: String
}
