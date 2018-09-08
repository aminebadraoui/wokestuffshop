//
//  String+html.swift
//  App
//
//  Created by Amine on 2018-07-29.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

extension String {
    
    func interpretAsHTML(font: String, size: CGFloat) -> NSAttributedString? {
        var style = ""
        
        style += "<style>* { "
        style += "font-family: \"\(font)\" !important;"
        style += "font-size: \(size) !important;"
        style += "}</style>"
        
        let styledHTML = self.trimmingCharacters(in: CharacterSet.newlines).appending(style)
        let htmlData   = styledHTML.data(using: .utf8)!
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType      : NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            ]
        
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
}
