//
//  Constants.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-13.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

struct ImageTestUrl {
    let url1 = "https://cdn.shopify.com/s/files/1/2137/9849/products/4PCS-Stainless-Steel-Colourful-Spoons-Korea-Dark-Black-Soup-Spoon-Long-Handle-Gold-Spoon-Set-for_4c8d93a0-7c8e-467e-8332-7cc105913b99_medium.jpg"
    let url2 = "https://cdn.shopify.com/s/files/1/2137/9849/products/blalsla_medium.jpg"
    let url3 = "https://cdn.shopify.com/s/files/1/2137/9849/products/6-Ways-Universal-Can-Opener-For-Opening-Jar-Can-Bottle-Wine-Kitchen-Practical-Multi-Purpose-All_14894566-d5f9-4d1c-9d58-177e8dcb549d_medium.jpg"
    let url4 = "https://cdn.shopify.com/s/files/1/2137/9849/products/product-image-483742998_1080x_4c637640-d71f-48d0-92ad-1f84200f9b81_medium.jpg"
    let url5 = "https://cdn.shopify.com/s/files/1/2137/9849/products/513w9gcaS_2BL_1024x1024_large_540x_dceb2d94-cda8-4e27-9b0b-92fd96a86d83_medium.jpg"
    let url6 = "https://cdn.shopify.com/s/files/1/2137/9849/products/cute-embroidery-Teddy-pug-HUSKY-dog-pet-cover-for-apple-iPhone-6-6s-plus-5-5_e21c9da1-7364-493c-974c-67ba4a74001b_medium.jpg"
    
    init() {
        
    }
    
    
}

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
        case bold
    }
    static func customFont(ofSize size: CGFloat, ofType type: FontType) -> UIFont {
        var fontName = ""
        switch type {
        case .light:
            fontName = "OpenSans-Light"
        case .regular:
            fontName = "OpenSans"
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
    static let productOldPrice = UIColor.red
}
