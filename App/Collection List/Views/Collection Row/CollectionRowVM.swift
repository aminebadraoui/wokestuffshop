//
//  CollectionRowVM.swift
//  App
//
//  Created by Amine on 2018-07-08.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit

class CollectionRowVM: TableCompatible {
    
    var collection: CollectionModel
    
    init(collection: CollectionModel){
        self.collection = collection
    }
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let collectionNode = CollectionNode()
        collectionNode.setup(vm: self)
        return collectionNode
    }
    
    
}
