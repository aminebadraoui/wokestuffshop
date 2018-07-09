//
//  HomeVM.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit


class HomeVM: NSObject{
    
    //  list o
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
//        dataSource.tableData = listOfHomeSections
        
        
    }


}
