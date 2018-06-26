//
//  ProductModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-06-25.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation

public struct ProductModel  {
    public var name: String
    public var price: String
    public var oldPrice: String
    public var imageURL: String
    
   public init(name: String) {
        self.name = name
        price = ""
        oldPrice = ""
        imageURL = ""
    }
}
