//
//  FeaturedProductViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-24.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class FeaturedProductViewModel : NSObject {
    var product: ProductModel
    
    init(product: ProductModel){
        self.product = product
    }
}
