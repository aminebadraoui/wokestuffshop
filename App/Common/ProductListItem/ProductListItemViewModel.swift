//
//  ProductViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class ProductViewModel: CollectionCompatible, TableCompatible {
   
    
    var product : ProductModel
    var name: String
    
    
    
    init (productModel: ProductModel) {
        self.product = productModel
        self.name = productModel.title
       

       
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productCellNode = ProductCellNode()
        productCellNode.setup(vm: self)
        return productCellNode
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productCellNode = ProductCellNode()
        productCellNode.setup(vm: self)
        return productCellNode
    }
    
    
}

