//
//  LineItemModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//
import MobileBuySDK

public struct LineItemModel {
    public let model:    Storefront.CheckoutLineItemEdge
    
    public let variantID:       String?
    public let title:           String
    public let quantity:        Int
    public let individualPrice: Decimal
    public let totalPrice:      Decimal
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(from model: Storefront.CheckoutLineItemEdge) {
        self.model           = model
        
        self.variantID       = model.node.variant!.id.rawValue
        self.title           = model.node.title
        self.quantity        = Int(model.node.quantity)
        self.individualPrice = model.node.variant!.price
        self.totalPrice      = self.individualPrice * Decimal(self.quantity)
    }
}

