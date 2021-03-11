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
