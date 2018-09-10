//
//  NSAttributedString+Joined.swift
//  App
//
//  Created by Amine Badraoui on 2018-09-09.
//  Copyright © 2018 Amine Badraoui. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: NSAttributedString {
    /// Returns a new attributed string by concatenating the elements of the sequence, adding the given separator between each element.
    /// - parameters:
    ///     - separator: A string to insert between each of the elements in this sequence. The default separator is an empty string.
    func joined(separator: NSAttributedString = NSAttributedString(string: "")) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    
    /// Returns a new attributed string by concatenating the elements of the sequence, adding the given separator between each element.
    /// - parameters:
    ///     - separator: A string to insert between each of the elements in this sequence. The default separator is an empty string.
    func joined(separator: String = "") -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }
}
