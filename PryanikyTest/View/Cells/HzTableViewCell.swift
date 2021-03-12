//
//  HzTableViewCell.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class HzTableViewCell: CellWithViewModel<HzCellViewModel> {

    @IBOutlet weak var cellText: UILabel!
    
    override var viewModel: HzCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            vm.text.bind(to: cellText.rx.text).disposed(by: vm.bag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
