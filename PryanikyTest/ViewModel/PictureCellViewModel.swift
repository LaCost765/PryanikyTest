//
//  PictureCellViewModel.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import Foundation
import RxSwift

class PictureCellViewModel: DataCellViewModel {

    var text: BehaviorSubject<String>
    var image: BehaviorSubject<String>
    
    required init(model: ServerDataItem) {
        
        text = BehaviorSubject(value: model.data.text ?? "")
        image = BehaviorSubject(value: model.data.url ?? "")
        super.init(model: model)
        
        text.subscribe(onNext: { [weak self] value in
            self?.model.data.text = value
        }).disposed(by: bag)
        
        image.subscribe(onNext: { [weak self] value in
            self?.model.data.url = value
        }).disposed(by: bag)
    }
}
