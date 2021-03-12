//
//  SelectorCellViewModel.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import Foundation
import RxSwift

class SelectorCellViewModel: DataCellViewModel {
    
    var selectedId: BehaviorSubject<Int>
    var displayedText: BehaviorSubject<String>
    
    required init(model: ServerDataItem) {
        
        selectedId = BehaviorSubject(value: model.data.selectedId ?? 0)
        
        let currentVariant = model.data.variants?.first { $0.id == Int(model.data.selectedId ?? 0)}
        displayedText = BehaviorSubject<String>(value: currentVariant?.text ?? "")
        
        super.init(model: model)
        
        selectedId.subscribe(onNext: { [weak self] value in
            self?.model.data.selectedId = value
        })
        
        displayedText.subscribe(onNext: { [weak self] value in
            let newId = (model.data.variants?.first { $0.text == value})?.id ?? 0
            
            self?.selectedId.onNext(newId)
        })
    }
}
