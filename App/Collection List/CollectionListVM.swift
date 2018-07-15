//
//  CollectionListVM.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift

class CollectionListVM: NSObject {
    
    let client = Client.shared
    let disposeBag = DisposeBag()
    
    var collectionList = [TableCompatible]()
    var dataSource = Datasource()
    
    var collections = [CollectionModel]()
    
    let title = "Collections"
    
    // 1. fetch the collections and map them to model
    // 2. create a collection row view model that is table compatible and takes the model as dependency
    // 3. append the row view model to collectionlist
    
    override init() {
        super.init()

    }
    
    func fetchCollections() {
        
        let collections = client.fetchCollections().asObservable().share(replay: 1)
        
        collections.observeOn(MainScheduler.instance)
        .subscribe(onNext: { collectionList in
            self.collectionList = collectionList.map {  CollectionRowVM(collection: $0) }
            self.dataSource.tableData = self.collectionList
            print(self.collectionList.count)
        }).disposed(by: disposeBag)
    }
    
}
