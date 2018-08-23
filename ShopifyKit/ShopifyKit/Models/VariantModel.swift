//
//  VariantModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

public struct  VariantModel {
    public let model:  Storefront.ProductVariant
    
    public let id:     String
    public let title:  String
    public let price:  Decimal
    public let compareAtPrice: Decimal?
    public let sku: String?
    public let availableForSale: Bool
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(from model: Storefront.ProductVariant) {
        self.model  = model
        self.id     = model.id.rawValue
        self.title  = model.title
        self.price  = model.price
        self.compareAtPrice = model.compareAtPrice
        self.sku = model.sku
        self.availableForSale = model.availableForSale
    }
}


