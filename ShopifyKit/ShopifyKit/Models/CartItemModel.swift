//
//  CartItemModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

public struct  CartItemModel {
    public let product: ProductModel
    public let variant: VariantModel
    public var quantity: Int
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(product: ProductModel, variant: VariantModel, quantity: Int = 1) {
        self.product  = product
        self.variant  = variant
        self.quantity = quantity
    }
}
