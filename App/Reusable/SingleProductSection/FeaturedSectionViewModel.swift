//
//  FeaturedSectionViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-22.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class FeaturedSectionViewModel : NSObject, ASTableCompatible {
  
    
    
    var sectionTitle: String
    var productDatasource: ProductModel
    
    
    init(title: String, productFeed: ProductModel) {
        self.sectionTitle = title
        self.productDatasource = productFeed
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let featuredProduct = FeaturedSectionNode()
        featuredProduct.setup(vm: self)
        return featuredProduct
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
}
