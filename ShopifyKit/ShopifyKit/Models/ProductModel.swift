//
//  ProductModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-06-25.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK


public struct ProductModel  {
    public var model: Storefront.Product
    public var title: String
    public var handle: String
    public var description: String
    public var id: String
    
    public init(from model: Storefront.Product) {
        self.model = model
        self.title = model.title
        self.handle = model.handle
        self.description = model.description
        self.id = model.id.rawValue
    }
}
