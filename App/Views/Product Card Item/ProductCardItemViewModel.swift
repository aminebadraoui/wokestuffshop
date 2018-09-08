//
//  ProductCardItemViewModel.swift
//  App
//
//  Created by Amine on 2018-08-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import ShopifyKit
import RxSwift

protocol ProductCardItemViewModelInputs {
    
}

protocol ProductCardItemViewModelOutputs {
    var cellTapped: Observable<Void> { get }
}

protocol ProductCardItemViewModelTypes {
    var inputs: ProductCardItemViewModelInputs { get }
    var outputs: ProductCardItemViewModelOutputs { get }
}

class ProductCardItemViewModel: CollectionCompatible, ProductCardItemViewModelInputs, ProductCardItemViewModelOutputs, ProductCardItemViewModelTypes {
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
        collectionView.register(ProductCardItemCell.self, forCellWithReuseIdentifier: "ProductCardItemCell")
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCardItemCell", for: indexPath) as! ProductCardItemCell
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
    
    var inputs: ProductCardItemViewModelInputs { return self }
    var outputs: ProductCardItemViewModelOutputs {  return self }


}
