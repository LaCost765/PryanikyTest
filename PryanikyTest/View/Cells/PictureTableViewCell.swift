//
//  PictureTableViewCell.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PictureTableViewCell: CellWithViewModel<PictureCellViewModel> {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellText: UILabel!
    
    override var viewModel: PictureCellViewModel? {
        didSet {
            
            // Понимаю, что не очень хорошо тут работать с url session, но в рамках задания решил так оставить
            guard let vm = viewModel else { return }
            vm.text.bind(to: cellText.rx.text).disposed(by: vm.bag)
            vm.image.bind { [unowned self] url in
                
                guard let url = URL(string: url) else { return }
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        self.cellImage.image = UIImage(data: data)
                        self.cellImage.setNeedsDisplay()
                    }
                }
                
                task.resume()
            }.disposed(by: vm.bag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
