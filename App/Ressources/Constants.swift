//
//  Constants.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-13.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

struct LayoutPadding {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let padding : CGFloat = 8
    static let productInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
}

struct AppFont {
    
    enum FontType {
        case light
        case regular
        case semibold
        case bold
    }
    
    static func customFont(ofSize size: CGFloat, ofType type: FontType) -> UIFont {
        var fontName: String
        
        switch type {
        case .light:
            fontName = "OpenSans-Light"
        case .regular:
            fontName = "OpenSans"
        case .semibold:
            fontName = "OpenSans-SemiBold"
        case .bold:
            fontName = "OpenSans-Bold"
            
        }
        
        guard let customFont = UIFont(name: fontName, size: size) else {
            fatalError("""
    Failed to load the custom font.
    Make sure the font file is included in the project and the font name is spelled correctly.
    """
            )
        }
        
        return customFont
    }
    
    static let productNameSize: CGFloat = 12
    static let productPriceSize: CGFloat = 11
    static let productOldPriceSize: CGFloat = 11
}

struct AppColor {
    static let defaultColor = UIColor.black
    static let productPrice = UIColor.black
    static let productOldPrice = UIColor.gray
    static let appBackground = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
}

struct HelperMethod {
    static func priceFormatter(price: Decimal?) -> String {
        let currencyFormatter = NumberFormatter()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle           = .currency
        currencyFormatter.locale                = Locale(identifier: "en_US_POSIX")
        
        guard let price = price else { return "" }
        return currencyFormatter.string(from: price as NSNumber) ?? ""
    }
}

struct Currency {
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    static func stringFrom(_ decimal: Decimal, currency: String? = nil) -> String {
        return self.formatter.string(from: decimal as NSDecimalNumber)!
    }
}
