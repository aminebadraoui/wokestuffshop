//
//  CollectionModel.swift
//  ShopifyKit
//
//  Created by Amine on 2018-07-02.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

public class Collection {
    
    public var model: Storefront.Collection
    public var title: String
    public var handle: String
    public var description: String
    public var imageUrl: URL?
    public var id: String
   
    public init(from model: Storefront.Collection) {
        self.model = model
        self.title = model.title
        self.handle = model.handle
        self.description = model.description
        self.imageUrl = model.image?.originalSrc
        self.id = model.id.rawValue
    }
    
    
}
