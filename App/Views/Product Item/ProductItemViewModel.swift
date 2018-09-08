//
//  ProductViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

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

class ProductItemViewModel: CollectionCompatible, ProductListItemInputs, ProductListItemOutputs, ProductListItemTypes {
    var product : ProductModel
    let productTitle: String
    let productPrice: String
    let productCompareAtPrice: String

    init (productModel: ProductModel) {
        self.product = productModel
        
        productTitle = productModel.title
        productPrice = Currency.stringFrom(productModel.variants.first?.price ?? 0.0)
        productCompareAtPrice = Currency.stringFrom(productModel.variants.first?.compareAtPrice ?? 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: "ProductCell")
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductItemCell
        productCell.configure(viewModel: self)
        
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

