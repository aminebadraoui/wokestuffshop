//
//  HomeViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

class HomeViewModel: NSObject{
    
    //  list o
    var listOfHomeSections = [TableCompatible]()
    var dataSource = Datasource()
    
    var latestProducts: [ProductModel]!
    var featuredProduct: ProductModel!
    var bestSellerProducts: [ProductModel]!
    
    override init() {
         super.init()
        
        // This whole section should be replaced by fetching data from viewModel
        mockProducts()
        let latest = ProductListViewModel(sectionType: .latest, productFeed: latestProducts)
        let bestSellers = ProductListViewModel(sectionType: .bestSellers, productFeed: bestSellerProducts)
        let featured = FeaturedSectionViewModel(sectionType: .featured, productFeed: featuredProduct)
        listOfHomeSections = [latest, featured, bestSellers ]
        
        dataSource.tableData = listOfHomeSections
    }
    

    
    
    
    
    

func mockProducts() {
    var product1 = ProductModel(name: "3-in-1 Emergency Escape Keychain Tool")
    product1.imageURL = "https://cdn.shopify.com/s/files/1/2137/9849/products/et2_medium.jpg"
    product1.price = "$19.99"
    product1.oldPrice = "$49.99"
    
    
    
    var product2 = ProductModel(name: "3D Magic Maze Ball")
    product2.imageURL = "https://cdn.shopify.com/s/files/1/2137/9849/products/3D-Magic-Maze-Ball-100-Levels-Intellect-Ball-Rolling-Ball-Puzzle-Game-Brain-Teaser-Baby-Learning_a6ef8102-3d73-42b0-9475-b6acce218b7b_medium.jpg"
    product2.price = "$19.99"
    product2.oldPrice = "$29.99"
    
    var product3 = ProductModel(name: "4 Pcs/set Silicone Magic Snake Cake Mold")
    product3.imageURL = "https://cdn.shopify.com/s/files/1/2137/9849/products/4-Pcs-set-Silicone-bakeware-Magic-Snake-cake-mold-DIY-Baking-square-rectangular-Heart-Shape-Round_c48c2b4f-e0e4-4a67-b170-b6e25f685481_medium.jpg"
    product3.price = "$12.00"
    product3.oldPrice = "$18.00"
    
    var product4 = ProductModel(name: "4PCS Stainless Steel Cutlery")
    product4.imageURL = "https://cdn.shopify.com/s/files/1/2137/9849/products/4PCS-Stainless-Steel-Colourful-Spoons-Korea-Dark-Black-Soup-Spoon-Long-Handle-Gold-Spoon-Set-for_4c8d93a0-7c8e-467e-8332-7cc105913b99_medium.jpg"
    product4.price = "$24.00"
    product4.oldPrice = "$40.00"
    
    var product5 = ProductModel(name: "6 Unique Flower Varieties of Blooming Tea(Comes with Heat-resistant Glas")
    product5.imageURL = "https://cdn.shopify.com/s/files/1/2137/9849/products/blalsla_medium.jpg"
    product5.price = "$45.95"
    product5.oldPrice = "$69.95"
    
  
    
    bestSellerProducts = [product4, product3, product2, product1]
    featuredProduct = product3
    latestProducts = [product1, product2, product4, product5]

}

}
