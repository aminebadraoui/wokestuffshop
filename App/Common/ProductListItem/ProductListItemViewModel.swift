//
//  ProductViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class ProductListItemViewModel: CollectionCompatible {
    
    var product : ProductModel

    
    init (productModel: ProductModel) {
        self.product = productModel
  
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productCellNode = ProductListItemCell()
        productCellNode.setup(vm: self)
        return productCellNode
    }

    
    
}

