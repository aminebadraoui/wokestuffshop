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
    var product: Product
    
    init(product: Product){
        self.product = product
    }
}
