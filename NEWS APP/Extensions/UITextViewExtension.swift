//
//  UITextViewExtension.swift
//  NEWS APP
//
//  Created by Eng Mahmoud on 28/12/2022.
//

import UIKit

extension UITextView {
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(16)\">%@</span>" as NSString, text)

        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
}
