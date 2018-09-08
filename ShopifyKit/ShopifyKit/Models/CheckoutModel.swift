//
//  CheckoutModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

public struct  CheckoutModel {
    public let model: Storefront.Checkout
    
    public let webURL: URL
    public let lineItems: [LineItemModel]
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(from model: Storefront.Checkout) {
        self.model = model
        
        self.webURL    = model.webUrl
        self.lineItems = model.lineItems.edges.map { LineItemModel(from: $0)}
    }
}

