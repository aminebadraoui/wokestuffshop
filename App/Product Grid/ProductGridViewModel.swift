//
//  ProductListVM.swift
//  App
//
//  Created by Amine on 2018-07-14.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift

protocol ProductGridViewModelInputs {
    var selectCollectionAction: AnyObserver<CollectionModel> { get }
}
protocol ProductGridViewModelOutputs {
    var selectedCollection: Observable<CollectionModel> { get }
    var datasourceOutput: Observable<Void> { get }
}

protocol ProductGridViewModelType {
    var outputs: ProductGridViewModelOutputs { get }
    var inputs: ProductGridViewModelInputs { get }
    
}
class ProductGridViewModel: ProductGridViewModelInputs, ProductGridViewModelOutputs, ProductGridViewModelType {
    
    let client = Client.shared
    
    let disposeBag = DisposeBag()
    
    let collection: CollectionModel
    var datasource = Datasource()
    var products = [ProductListItemViewModel]()
    
    let title = "Products"
    
    init(collection: CollectionModel) {
        self.collection = collection
    }
    
    func fetchProducts() {
        
        let productsObservable = client.fetchProducts(in: collection).asObservable().share(replay: 1)
        
        productsObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { productList in
                self.products = productList.map { ProductListItemViewModel(productModel: $0) }
                
                self.datasource.collectionData = self.products
                self._datasourceSubject.onNext(()) 
            }).disposed(by: disposeBag)
    }
    
    //  Subjects
    private var _selectedCollection = PublishSubject<CollectionModel>()
    private var _datasourceSubject = PublishSubject<Void>()
    
    //  Inputs
    var selectCollectionAction: AnyObserver<CollectionModel> {
        return _selectedCollection.asObserver()
    }
    
    //  Outputs
    var selectedCollection: Observable<CollectionModel> {
        return _selectedCollection.asObservable()
    }
    var datasourceOutput: Observable<Void> {
        return _datasourceSubject.asObservable()
    }
    
    var inputs: ProductGridViewModelInputs { return self }
    var outputs: ProductGridViewModelOutputs { return self }
    
}
