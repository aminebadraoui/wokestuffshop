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
    public var price: [Decimal]
    public var compareAtPrice: [Decimal?]
    public var availableForSale: [Bool]
    public var sku: [String?]
    public var options: [Storefront.ProductOption]
    public var variants: [Storefront.ProductVariantEdge]
    
    public init(from model: Storefront.Product) {
        self.model = model
        self.title = model.title
        self.handle = model.handle
        self.description = model.descriptionHtml
        self.images = model.images.edges.map { $0.node.originalSrc }
        self.id = model.id.rawValue
        self.price = model.variants.edges.map { $0.node.price}
        self.compareAtPrice = model.variants.edges.map { $0.node.compareAtPrice }
        self.availableForSale = model.variants.edges.map { $0.node.availableForSale }
        self.sku = model.variants.edges.map { $0.node.sku }
        self.options = model.options
        self.variants = model.variants.edges
    }
}

