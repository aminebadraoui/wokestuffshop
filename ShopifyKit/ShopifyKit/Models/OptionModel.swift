//
//  OptionModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-12.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

public struct  OptionModel {
    public let model:  Storefront.ProductOption
    
    public let id:     String
    public let name:  String
    public let values:  [String]
    public var selectedValue: String
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(from model: Storefront.ProductOption) {
        self.model  = model
        
        self.id     = model.id.rawValue
        self.name  = model.name
        self.values = model.values
        self.selectedValue = model.values.first ?? ""
        
    }
}
