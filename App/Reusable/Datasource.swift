//
//  Datasource.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-20.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

 class Datasource: NSObject {
    
    var collectionData = [CollectionCompatible]()
    var tableData      = [TableCompatible]()

}

extension Datasource : ASCollectionDelegate, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return collectionData[indexPath.row].collectionNode(collectionNode, nodeForRowAt: indexPath)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        collectionData[indexPath.row].collectionNode(collectionNode, didSelectItemAt: indexPath)
    }
}


extension Datasource:  ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = tableData[indexPath.row].tableNode(tableNode, nodeForRowAt: indexPath)
        return node
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableData[indexPath.row].tableNode(tableNode, didSelectRowAt: indexPath)
    }

}
