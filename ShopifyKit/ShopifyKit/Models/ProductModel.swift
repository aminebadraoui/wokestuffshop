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
    public var images: [URL]
    public var id: String
    public var options: [OptionModel]
    public var variants: [VariantModel]
    
    public init(from model: Storefront.Product) {
        self.model = model
        
        self.title = model.title
        self.handle = model.handle
        self.description = model.descriptionHtml
        self.images = model.images.edges.map { $0.node.originalSrc }
        self.id = model.id.rawValue
        self.options = model.options.map { OptionModel(from: $0)}
        self.variants = model.variants.edges.map { VariantModel(from: $0.node)}
    }
}

