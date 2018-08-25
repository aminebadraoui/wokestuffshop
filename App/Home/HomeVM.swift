//
//  HomeVM.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit.ASTableNode
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
    
    var dataSource = Datasource()
    
    let client = Client.shared
    
    var _selectedProduct = PublishSubject<ProductModel>()
    
    init() {
        buildDatasource()
        
        dataSource.ASTableData.forEach({ table in
        
            let list = table as? ProductListSectionViewModel
            list?._selectedProductSubject
                .bind(to: _selectedProduct)
                .disposed(by: disposeBag)
            
        })
    }
    
    func buildDatasource() {
        
        let latest   = createList(handle: CollectionHandle.sale.rawValue, title: "Latest")

        let featuredProduct = createFeaturedProduct(handle: CollectionHandle.sale.rawValue, title: "Featured Product")

        let best     = createList(handle: CollectionHandle.bestsellers.rawValue, title: "Best Seller")
        
        let featuredCollection = createFeaturedCollection(handle: CollectionHandle.sale.rawValue, title: "Featured Collection")
        
        let datasourceObservable = Observable.combineLatest(featuredCollection, latest, featuredProduct, best ).share(replay: 1)
        
        datasourceObservable
            .do(onNext: { featuredCollection, latest, featured, best in
                
            })
            .subscribe(onNext: { featuredCollection, latest, featured, best in
                self.dataSource.ASTableData = [featuredCollection, latest, featured, best]
            })
            
            .disposed(by: disposeBag)
        
        datasourceObservable
            .map { featuredCollection, latest, featured, best in ()
                
                latest._selectedProductSubject
                    .bind(to: self._selectedProduct)
                    .disposed(by: self.disposeBag)
                
                featured.selectedFeaturedProductSubject
                .bind(to: self._selectedProduct)
                .disposed(by: self.disposeBag)
                
                best._selectedProductSubject
                    .bind(to: self._selectedProduct)
                    .disposed(by: self.disposeBag)
            }
            .bind(to: _datasourceSubject)
            .disposed(by: disposeBag)
    }
    
    public func createList(handle: String, title: String) -> Observable<ProductListSectionViewModel> {
        return  client.fetchCollection(handle: handle)
            .flatMap { collection in
                self.client.fetchProducts(in: collection)
            }
            .map { productList in
                return ProductListSectionViewModel(title: title, productFeed: productList)
        }
        
    }
    
    public func createFeaturedProduct(handle: String, title: String) -> Observable <FeaturedSectionViewModel> {
        return client.fetchCollection(handle: handle)
            .flatMap{ collection in
                self.client.fetchProducts(in: collection)
            }
            .map{ productList in
                return  FeaturedSectionViewModel(title: title, productFeed: productList.first!)
        }
    }
    
    public func createFeaturedCollection(handle: String, title: String) -> Observable <CollectionRowVM> {
        return client.fetchCollection(handle: handle)
            .map{ collection in
                return CollectionRowVM(collection: collection)
            }
        
    }
    
    private var _datasourceSubject = PublishSubject<Void>()
    
    var datasourceOutput: Observable<Void> { return _datasourceSubject.asObservable() }
    var inputs: HomeVMInputs { return self }
    var outputs: HomeVMOutputs { return self }
    
}
