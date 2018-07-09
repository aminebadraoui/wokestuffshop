//
//  ProductListViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class ProductListViewModel : NSObject, TableCompatible {
   
    //  Properties
    let sectionTitle: String
    var productListDatasource: [Product]!
    
    //  initialization
    init(sectionType: SectionType, productFeed: [Product]) {
        self.sectionTitle          = sectionType.rawValue
        self.productListDatasource = productFeed
    }
    
    //  Delegate method
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productList = ProductListNode()
        productList.setup(vm: self)
        return productList
    }
}
