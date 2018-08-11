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
import RxCocoa

protocol CollectionListInputs {
    
}

protocol CollectionListOutputs {
    var selectedCollection: Observable<CollectionModel> { get }
}

protocol CollectionListType {
    var inputs: CollectionListInputs { get }
    var outputs: CollectionListOutputs { get }
}
class CollectionListVM: CollectionListOutputs, CollectionListInputs, CollectionListType {
    
    let client = Client.shared
    let disposeBag = DisposeBag()
    
    var collectionList = [ASTableCompatible]()
    var dataSource = Datasource()
    
    let title = "Collections"
    
    func fetchCollections() {
        
        let collections = client.fetchCollections().asObservable().share(replay: 1)
        
        collections.observeOn(MainScheduler.instance)
        .subscribe(onNext: { collectionModelList in
            
            self.collectionList = collectionModelList.map { collectionModel -> CollectionRowVM in
                
                let row = CollectionRowVM(collection: collectionModel)
                
                row.outputs.cellTapped
                    .map{ _ in collectionModel }
                    .bind(to: self._selectedCollectionSubject)
                    .disposed(by: self.disposeBag)
   
                return row
                
                }
            
            self.dataSource.ASTableData = self.collectionList
          
        }).disposed(by: disposeBag)
    }
    
    //  Subjects
    private  var _selectedCollectionSubject = PublishSubject<CollectionModel>()
    
    //  Outputs
    var selectedCollection: Observable<CollectionModel> {
        return _selectedCollectionSubject.asObservable()
    }
    
    var inputs: CollectionListInputs { return self }
    var outputs: CollectionListOutputs { return self }
 
}
