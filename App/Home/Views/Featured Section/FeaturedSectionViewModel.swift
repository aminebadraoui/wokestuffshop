//
//  FeaturedSectionViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-22.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class FeaturedSectionViewModel : NSObject, TableCompatible {
    
    var sectionTitle: String
    var productDatasource: ProductModel 
    
    
    init(sectionType: SectionType, productFeed: ProductModel) {
        self.sectionTitle = sectionType.rawValue
        self.productDatasource = productFeed
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let featuredProduct = FeaturedSectionNode()
        featuredProduct.setup(vm: self)
        return featuredProduct
    }
}
