//
//  Datasource.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-20.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

 class Datasource: NSObject {

    var ASCollectionData = [ASCollectionCompatible]()
    var ASTableData      = [ASTableCompatible]()
    var collectionData   = [CollectionCompatible]()
    var tableData        = [TableCompatible]()

}

extension Datasource : ASCollectionDelegate, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return ASCollectionData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ASCollectionData[indexPath.row].collectionNode(collectionNode, nodeForRowAt: indexPath)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        ASCollectionData[indexPath.row].collectionNode(collectionNode, didSelectItemAt: indexPath)
    }
}


extension Datasource:  ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return ASTableData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = ASTableData[indexPath.row].tableNode(tableNode, nodeForRowAt: indexPath)
        return node
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        ASTableData[indexPath.row].tableNode(tableNode, didSelectRowAt: indexPath)
    }
}

extension Datasource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return tableData[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData[indexPath.row].height
    }
}

extension Datasource: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionData[indexPath.row].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    
}
