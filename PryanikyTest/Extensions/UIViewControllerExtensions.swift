//
//  UIViewControllerExtensions.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Добавил, чтобы в alert отображать информацию о ячейке при клике на нее
    func showNotificationAlert(title: String, message: String, buttonTitle: String, style: UIAlertAction.Style = .default) {
        
        let ok = UIAlertAction(title: buttonTitle, style: style)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
