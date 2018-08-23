//
//  ProductListSectionViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import RxSwift
import RxCocoa

class ProductListSectionViewModel : NSObject, ASTableCompatible {
    
    //  Properties
    let sectionTitle: String
    var productListDatasource: [ProductModel]!
    
    var _selectedProductSubject =  PublishSubject<ProductModel>()
    var disposeBag = DisposeBag()
    
    //  initialization
    init(title: String, productFeed: [ProductModel]) {
        self.sectionTitle          = title
        self.productListDatasource = productFeed
    }
    
    //  Delegate method
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productList = ProductListNode()
        productList.setup(vm: self)
        
        productList._selectedProductSubject
            .bind(to: _selectedProductSubject)
            .disposed(by: disposeBag)
        
        return productList
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
    }
}
