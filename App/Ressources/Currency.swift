//
//  Currency.swift
//  App
//
//  Created by Amine on 2018-08-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation

struct Currency {
    
    private static let formatter: NumberFormatter = {
        let formatter         = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static func stringFrom(_ decimal: Decimal, currency: String? = nil) -> String {
        return self.formatter.string(from: decimal as NSDecimalNumber)!
    }
}
