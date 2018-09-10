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
    let productTitleAttributed: NSAttributedString
    
    let productPriceBlock: NSAttributedString
    
    init (productModel: ProductModel) {
        self.product = productModel
        
        let productTitle = productModel.title
        
        let productPrice = Currency.stringFrom(productModel.variants.first?.price ?? 0.0)
        
        let productCompareAtPrice: String
        if let productCompareAtPriceDecimal = productModel.variants.first?.compareAtPrice {
            productCompareAtPrice = Currency.stringFrom(productCompareAtPriceDecimal)
        } else {
             productCompareAtPrice = ""
        }
        
        //  Text Configuration
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let productNameAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productNameSize, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productPriceAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productPriceSize, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productPrice,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productOldPriceAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productOldPriceSize, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productOldPrice ,
            NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        productTitleAttributed = NSAttributedString(string: productTitle, attributes: productNameAttributes)
        
        let productPriceAttributed = NSAttributedString(string: productPrice, attributes: productPriceAttributes)
        let productOldPriceAttributed = NSAttributedString(string: productCompareAtPrice, attributes: productOldPriceAttributes)
        
        productPriceBlock = [productPriceAttributed,productOldPriceAttributed].filter{ !$0.string.isEmpty }.joined(separator: NSAttributedString(string: " - "))
       
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
