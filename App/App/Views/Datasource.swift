//
//  Datasource.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-20.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

 class Datasource: NSObject {
    var collectionData   = [CollectionCompatible]()
    var tableData        = [TableCompatible]()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableData[indexPath.row].tableView(tableView, didSelectRowAt: indexPath)
    }
}

extension Datasource: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionData[indexPath.row].collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return collectionData[indexPath.row].collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
