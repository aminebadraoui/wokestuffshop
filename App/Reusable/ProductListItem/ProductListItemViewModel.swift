//
//  ProductViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import RxSwift

protocol ProductListItemInputs {
    
}

protocol ProductListItemOutputs {
    var cellTapped: Observable<Void> { get }
}

protocol ProductListItemTypes {
    var inputs: ProductListItemInputs { get }
    var outputs: ProductListItemOutputs { get }
}

class ProductListItemViewModel: CollectionCompatible , ProductListItemInputs, ProductListItemOutputs, ProductListItemTypes {
   
    var product : ProductModel

    
    init (productModel: ProductModel) {
        self.product = productModel
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let productCellNode = ProductListItemCell()
        productCellNode.setup(vm: self)
        return productCellNode
    }
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        _cellTapSubject.onNext(())
    }
    
    //  Subjects
    var _cellTapSubject = PublishSubject<Void>()
    
    //  Outputs
    var cellTapped: Observable<Void> {
        return _cellTapSubject.asObservable()
    }
    
    var inputs: ProductListItemInputs { return self }
    var outputs: ProductListItemOutputs {  return self }

    
    
}

