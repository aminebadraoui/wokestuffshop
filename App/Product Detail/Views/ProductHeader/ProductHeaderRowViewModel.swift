//
//  ProductHeaderRowViewModel.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import ShopifyKit

protocol ProductHeaderRowViewModelInputs {
    
}

protocol ProductHeaderRowViewModelOutputs {
    var nameView: Observable<NSAttributedString> { get }
    var priceView: Observable<NSAttributedString> { get }
    var compareAtPriceView: Observable<NSAttributedString> { get }
}

protocol ProductHeaderRowViewModelTypes {
    var inputs: ProductHeaderRowViewModelInputs { get }
    var outputs: ProductHeaderRowViewModelOutputs { get }
}

/******************************/
class ProductHeaderRowViewModel: TableCompatible, NibReusable, ProductHeaderRowViewModelInputs, ProductHeaderRowViewModelOutputs, ProductHeaderRowViewModelTypes {
  
    init(product: ProductModel){
    self.product = product
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: ProductHeaderCell.self)
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductHeaderCell.self)
        
        cell.configure(row: self)
        
        let productTitle = formatProductName(product.title)
        let productPrice = formatCurrentPrice(product.price.first)
        let productCompareAtPrice = formatCompareAt(product.compareAtPrice.first)
        
        _nameSubject.onNext(productTitle)
        _priceSubject.onNext(productPrice)
        _compareAtPriceSubject.onNext(productCompareAtPrice)
        return cell
    }
    
    private func formatCompareAt(_ price: Decimal??) -> NSAttributedString{
        let productCompareAtPrice = HelperMethods.priceFormatter(price: price ?? nil)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let productOldPriceAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 14, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productOldPrice ,
            NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productCompareAtPriceAtt = NSAttributedString(string: productCompareAtPrice, attributes: productOldPriceAttributes)
        
        return productCompareAtPriceAtt
    }
    
    private func formatCurrentPrice(_ price: Decimal?) -> NSAttributedString{
        let productCurrentPrice = HelperMethods.priceFormatter(price: price )
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let productPriceAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 14, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productPrice,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productCurrentPriceAtt = NSAttributedString(string: productCurrentPrice, attributes: productPriceAttributes)
        
        return productCurrentPriceAtt
    }
    
    private func formatProductName(_ productName: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        
        let productNameAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 18, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
         let productNamePriceAtt = NSAttributedString(string: productName, attributes: productNameAttributes)
        
        return productNamePriceAtt
    }
    
    /********************************************/
    //  Variables
    var height: CGFloat = UITableViewAutomaticDimension
    private var product: ProductModel
    
    //  Subjects
    private var _nameSubject = PublishSubject<NSAttributedString>()
    private var _priceSubject = PublishSubject<NSAttributedString>()
    private var _compareAtPriceSubject = PublishSubject<NSAttributedString>()
    
    //  Outputs
    var nameView: Observable<NSAttributedString> {
        return _nameSubject.asObservable()
    }
    var priceView: Observable<NSAttributedString> {
        return _priceSubject.asObservable()
    }
    var compareAtPriceView: Observable<NSAttributedString> {
        return _compareAtPriceSubject.asObservable()
    }
    
    //  Types
    var inputs: ProductHeaderRowViewModelInputs { return self }
    var outputs: ProductHeaderRowViewModelOutputs { return self }
}
