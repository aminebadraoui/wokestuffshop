//
//  ProductListViewModel.swift
//  App
//
//  Created by Amine on 2018-07-14.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift
import RxCocoa

protocol ProductGridViewModelInputs {
    var selectProductAction: AnyObserver<ProductModel> { get }
}
protocol ProductGridViewModelOutputs {
    var selectedProduct: Observable<ProductModel> { get }
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
    var products = [ProductItemViewModel]()
    
    let title: String
    
    init(collection: CollectionModel) {
        self.collection = collection
        title = collection.title
    }
    
    func fetchProducts() {
        
        let productsObservable = client.fetchProducts(in: collection).asObservable().share(replay: 1)
        let cellDisposeBag = DisposeBag()
        
        productsObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { productList in
                self.products = productList.map { product in
                    let cell = ProductItemViewModel(productModel: product)
                
                 cell.outputs.cellTapped
                    .map{ _ in product }
                    .bind(to: self._selectedProductSubject)
                    .disposed(by: cellDisposeBag)
                    return cell
                }
                
                self.datasource.collectionData = self.products
                self._datasourceSubject.onNext(())
            }).disposed(by: disposeBag)
    }
    
    //  Subjects
    private var _selectedProductSubject = PublishSubject<ProductModel>()
    private var _datasourceSubject = PublishSubject<Void>()
    
    //  Inputs
    var selectProductAction: AnyObserver<ProductModel> {
        return _selectedProductSubject.asObserver()
    }
    
    //  Outputs
    var selectedProduct: Observable<ProductModel> {
        return _selectedProductSubject.asObservable()
    }
    var datasourceOutput: Observable<Void> {
        return _datasourceSubject.asObservable()
    }
    
    var inputs: ProductGridViewModelInputs { return self }
    var outputs: ProductGridViewModelOutputs { return self }
    
}
