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
    var listOfHomeSections = [TableCompatible]()
    var dataSource = Datasource()
    
    var latestProducts: [ProductModel]!
    var featuredProduct: ProductModel!
    var bestSellerProducts: [ProductModel]!
    
    let client = Client.shared
    
   init() {
   
        
       

        
        
        
//        // This whole section should be replaced by fetching data from viewModel
//        mockProducts()
       
        //let bestSellers = ProductListViewModel(sectionType: .bestSellers, productFeed: bestSellerProducts)
       // let featured = FeaturedSectionViewModel(sectionType: .featured, productFeed: featuredProduct)
        
        

       
  
    }
    
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
                self.listOfHomeSections.append(latest)
                self.dataSource.tableData = self.listOfHomeSections
                self._datasourceSubject.onNext(())
            } ).disposed(by: disposeBag)
    }
    
    private var _datasourceSubject = PublishSubject<Void>()

    var datasourceOutput: Observable<Void> { return _datasourceSubject.asObservable() }
    var inputs: HomeVMInputs { return self }
    var outputs: HomeVMOutputs { return self }

}
