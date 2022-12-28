//
//  UIViewControllerExtensions.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit

extension UIViewController {
    func alert(message: String, completion: (() -> Void)? = nil)  {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .destructive) { _ in
            alert.dismiss(animated: true, completion: nil)
            completion?()
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
