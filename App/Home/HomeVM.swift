//
//  HomeVM.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import RxSwift

protocol HomeVMInputs {
    
}
protocol HomeVMOutputs {
    
    var datasourceOutput: Observable<Void> { get }
}

protocol HomeVMType {
    var outputs: HomeVMOutputs { get }
    var inputs: HomeVMInputs { get }
}

class HomeVM: HomeVMInputs, HomeVMOutputs, HomeVMType  {
    
    let disposeBag = DisposeBag()
    var listOfHomeSections = [ASTableCompatible]()
    var dataSource = Datasource()
    
    var latestProducts: [ProductModel]!
    var featuredProduct: ProductModel!
    var bestSellerProducts: [ProductModel]!
    
    let client = Client.shared
    
    var _selectedProduct = PublishSubject<ProductModel>()
    
    public func createList(handle: String, title: String){
        client.fetchCollection(handle: handle)
            .observeOn(MainScheduler.instance)
            .flatMap{ collection in
                self.client.fetchProducts(in: collection)
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { productList in
                self.latestProducts = productList
                
                let latest = ProductListSectionViewModel(title: title, productFeed: self.latestProducts)
                
                latest._selectedProductSubject
                    .bind(to: self._selectedProduct)
                    .disposed(by: self.disposeBag)
                
                self.listOfHomeSections.append(latest)
                
                self.dataSource.ASTableData = self.listOfHomeSections
                
                self._datasourceSubject.onNext(())
            } ).disposed(by: disposeBag)
    }
    
    private var _datasourceSubject = PublishSubject<Void>()
    
    var datasourceOutput: Observable<Void> { return _datasourceSubject.asObservable() }
    var inputs: HomeVMInputs { return self }
    var outputs: HomeVMOutputs { return self }
    
}
