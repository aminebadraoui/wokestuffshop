//
//  ProductModel.swift
//  WokeStuffShopKit
//
//  Created by Amine on 2018-06-16.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation

struct ProductModel  {
    var name: String
    var price: String
    var oldPrice: String
    var imageURL: String
    
    init(name: String) {
        self.name = name
        price = ""
        oldPrice = ""
        imageURL = ""
    }
}

