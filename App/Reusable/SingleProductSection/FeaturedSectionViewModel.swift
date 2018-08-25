//
//  FeaturedSectionViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-22.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import RxSwift

class FeaturedSectionViewModel : NSObject, ASTableCompatible {
  
    var sectionTitle: String
    var productDatasource: ProductModel
    var selectedFeaturedProductSubject = PublishSubject<ProductModel>()
    
    init(title: String, productFeed: ProductModel) {
        self.sectionTitle = title
        self.productDatasource = productFeed
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let featuredProduct = FeaturedSectionNode()
        featuredProduct.setup(vm: self)
        return featuredProduct
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        selectedFeaturedProductSubject.onNext(self.productDatasource)
     
    }

    func tableNode(_ tableNode: ASTableNode, didHighlightRowAt indexPath: IndexPath) {
//        tableNode.nodeForRow(at: indexPath)?.backgroundColor = .white
    }
}
