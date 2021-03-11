//
//  DataItem.swift
//  PryanikyTest
//
//  Created by Egor on 11.03.2021.
//

import Foundation

struct ServerDataItem: Codable {
    var name: String
    var data: ServerDataType
}

enum ServerDataType {
    case hz(text: String)
    case picture(url: String, text: String)
    case selector(selectedId: Int, variants: [SelectorItemData])
}

extension ServerDataType {
    private enum CodingKeys: String, CodingKey {
        case text = "text"
        case url = "url"
        case selectedId = "selectedId"
        case variants = "variants"
    }
}

extension ServerDataType: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .hz(text: let text):
            try container.encode(text, forKey: .text)
            
        case .picture(url: let url, text: let text):
            try container.encode(url, forKey: .url)
            try container.encode(text, forKey: .text)
            
        case .selector(selectedId: let selectedId, variants: let variants):
            //
            try container.encode(selectedId, forKey: .selectedId)
            try container.encode(variants, forKey: .variants)
        }
    }
}

extension ServerDataType: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        
        switch key {
        
        case .variants, .selectedId:
            let selectedId = try container.decode(Int.self, forKey: .selectedId)
            let variants = try container.decode([SelectorItemData].self, forKey: .variants)
            self = .selector(selectedId: selectedId, variants: variants)
            
        case .text:
            let text = try container.decode(String.self, forKey: .text)
            self = .hz(text: text)
            
        case .url:
            let url = try container.decode(String.self, forKey: .url)
            let text = try container.decode(String.self, forKey: .text)
            self = .picture(url: url, text: text)
//        case .hz:
//            let text = try container.decode(String.self, forKey: .text)
//            self = .hz(text: text)
//
//        case .picture:
//            let url = try container.decode(String.self, forKey: .url)
//            let text = try container.decode(String.self, forKey: .text)
//            self = .picture(url: url, text: text)
//
//        case .selector:
//            let selectedId = try container.decode(Int.self, forKey: .selectedId)
//            let variants = try container.decode([SelectorItemData].self, forKey: .variants)
//            self = .selector(selectedId: selectedId, variants: variants)
            
        default:
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "Unabled to decode enum."))
        }
    }
}
