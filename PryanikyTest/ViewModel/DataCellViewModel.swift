//
//  DataCellViewModel.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import Foundation
import RxSwift

class DataCellViewModel {
    var model: ServerDataItem
    var bag: DisposeBag = DisposeBag()
    
    var uniqueValue: String {
        return "Data type: \(model.name.rawValue)"
    }
    
    required init(model: ServerDataItem) {
        self.model = model
    }
}
