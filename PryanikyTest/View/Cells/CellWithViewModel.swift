//
//  CellWithViewModel.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import UIKit

// Ячейка, которая содержит в себе вью модель
class CellWithViewModel<ViewModelType: DataCellViewModel>: UITableViewCell {
    var viewModel: ViewModelType?
}
