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


class HomeVM: NSObject{
    
 let disposeBag = DisposeBag()
    var listOfHomeSections = [TableCompatible]()
    var dataSource = Datasource()
    
//    var latestProducts: [ProductModel]!
//    var featuredProduct: ProductModel!
//    var bestSellerProducts: [ProductModel]!
    
    override init() {
         super.init()
        
//        // This whole section should be replaced by fetching data from viewModel
//        mockProducts()
//        let latest = ProductListViewModel(sectionType: .latest, productFeed: latestProducts)
//        let bestSellers = ProductListViewModel(sectionType: .bestSellers, productFeed: bestSellerProducts)
//        let featured = FeaturedSectionViewModel(sectionType: .featured, productFeed: featuredProduct)
//        listOfHomeSections = [latest, featured, bestSellers ]
//
       
        
        fetchProductsOnSale()
    }
    
    func fetchProductsOnSale() {
        let onSaleCollection = Client.shared.fetchCollection(handle: "sale").asObservable().share(replay: 1)
        
        onSaleCollection.observeOn(MainScheduler.instance)
            .flatMap {collection in
                Client.shared.fetchProducts(in: collection)
            }
            .map { products in
                return ProductListViewModel(sectionType: .latest, productFeed: products)
               
            }.subscribe(onNext: { latest in
                self.listOfHomeSections.append(latest)
                print("LIST HOME \(self.listOfHomeSections.count)")
                self.dataSource.tableData = self.listOfHomeSections
                
            }).disposed(by: disposeBag)


    }
}
