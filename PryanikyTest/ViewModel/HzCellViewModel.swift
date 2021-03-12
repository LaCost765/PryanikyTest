//
//  HzCellViewModel.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import Foundation
import RxSwift

class HzCellViewModel: DataCellViewModel {

    var text: BehaviorSubject<String>
    
    required init(model: ServerDataItem) {
        
        text = BehaviorSubject(value: model.data.text ?? "")
        super.init(model: model)
        
        text.subscribe(onNext: { [weak self] value in
            self?.model.data.text = value
        }).disposed(by: bag)
    }
}
