//
//  UIViewControllerExtensions.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit
import MOLH

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
extension UIViewController {
    func configLang() {
        if MOLHLanguage.isArabic() {
            for vi in self.view.allSubviews as [UIView] {
                if let labelReference = vi as? UILabel {
                    if labelReference.textAlignment != .center && labelReference.textAlignment != .justified {
                        labelReference.textAlignment = .right
                    }
                }
                if let fieldRefernce = vi as? UITextField {
                    fieldRefernce.textAlignment = .right
                }
            }
        } else {
            for vi in self.view.allSubviews as [UIView] {
                if let labelReference = vi as? UILabel {
                    if labelReference.textAlignment != .center && labelReference.textAlignment != .justified {
                        labelReference.textAlignment = .left
                    }
                }
                if let fieldRefernce = vi as? UITextField {
                    fieldRefernce.textAlignment = .left
                }
            }
        }
    }
    func changeLanguageAction() {
            let alert = UIAlertController(title: "Languages".localize, message: "choose app language".localize, preferredStyle: .actionSheet)
            let englishAction = UIAlertAction(title: "English".localize, style: .default) { action in
                UserDefaults.standard.setValue("en", forKey: "lang")
                UserDefaults.standard.synchronize()
                MOLH.setLanguageTo("en")
                MOLH.reset()
                UserDefaults.standard.synchronize()
                DispatchQueue.main.async {
                    self.goToHome()
                }
            }
            let frenshAction = UIAlertAction(title: "Frensh".localize, style: .default) { action in
                UserDefaults.standard.setValue("fr", forKey: "lang")
                UserDefaults.standard.synchronize()
                MOLH.setLanguageTo("fr")
                MOLH.reset()
                UserDefaults.standard.synchronize()
                DispatchQueue.main.async {
                    self.goToHome()
                }
            }
            let arabicAction = UIAlertAction(title: "Arabic".localize, style: .default) { action in
                UserDefaults.standard.setValue("ar", forKey: "lang")
                MOLH.setLanguageTo("ar")
                MOLH.reset()
                UserDefaults.standard.synchronize()
                DispatchQueue.main.async {
                    self.goToHome()
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel) { action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(englishAction)
            alert.addAction(frenshAction)
            alert.addAction(arabicAction)
            alert.addAction(cancelAction)
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view //to set the source of your alert
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
            }
            self.present(alert, animated: true, completion: nil)
        }
    func goToHome() {
        let root = UIStoryboard(name: "TabBar", bundle: .main).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        UIView.transition(with: delegate.window!, duration: 0.5, options: .transitionFlipFromLeft) {
            delegate.window?.rootViewController = root
        } completion: { _ in}
        delegate.window?.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    
    func openURL(url: String) {
        guard let url = URL(string: "\(url)") else { return }
        UIApplication.shared.open(url)
    }
}

extension UIView {
    
    func configLang() {
        if MOLHLanguage.isArabic() {
            for vi in self.allSubviews as [UIView] {
                if let labelReference = vi as? UILabel {
                    if labelReference.textAlignment != .center && labelReference.textAlignment != .justified {
                        labelReference.textAlignment = .right
                    }
                }
                if let fieldRefernce = vi as? UITextField {
                    fieldRefernce.textAlignment = .right
                }
            }
        } else {
            for vi in self.allSubviews as [UIView] {
                if let labelReference = vi as? UILabel {
                    if labelReference.textAlignment != .center && labelReference.textAlignment != .justified {
                        labelReference.textAlignment = .left
                    }
                }
                if let fieldRefernce = vi as? UITextField {
                    fieldRefernce.textAlignment = .left
                }
            }
        }
    }
    
    var allSubviews: [UIView] {
        return self.subviews.flatMap { [$0] + $0.allSubviews }
    }
}
extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}
