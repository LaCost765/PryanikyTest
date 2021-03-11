//
//  SelectorData.swift
//  PryanikyTest
//
//  Created by Egor on 11.03.2021.
//

import Foundation

struct SelectorData: Codable {
    var selectedId: String
    var variants: [SelectorItemData]
}
