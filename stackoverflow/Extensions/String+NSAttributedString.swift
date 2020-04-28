//
//  String+NSAttributedString.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString.string.components(separatedBy: .newlines).joined() 
    }
    
    func attributedStringWithColor(strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: characterSpacing,
                                      range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
