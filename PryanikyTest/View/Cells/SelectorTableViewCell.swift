//
//  SelectorTableViewCell.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SelectorTableViewCell: CellWithViewModel<SelectorCellViewModel> {

    @IBOutlet weak var currentVariantText: UILabel!
    @IBOutlet weak var showVariantsButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    override var viewModel: SelectorCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            vm.displayedText.bind(to: currentVariantText.rx.text).disposed(by: vm.bag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Пикер для выбора значения в селекторе
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .black
        picker.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func showVariantsButtonTapped(_ sender: Any) {
        picker.isHidden = false
    }
}

extension SelectorTableViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.data.variants?.count ?? 0
    }
}

extension SelectorTableViewCell: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let variants = viewModel?.model.data.variants else { return }
        
        currentVariantText.text = variants[row].text
        pickerView.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        guard let variants = viewModel?.model.data.variants else { return NSAttributedString(string: "")}
        let str =  "\(variants[row].text) (id = \(variants[row].id))"
        
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
