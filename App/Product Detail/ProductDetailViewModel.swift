//
//  ProductDetailViewModel.swift
//  App
//
//  Created by Amine on 2018-07-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift
import RxCocoa
import MobileBuySDK

//  Inputs
protocol ProductDetailViewModelInputs {
    var atcAction: AnyObserver<Void>{ get }
    var selectOptionAction: AnyObserver<Storefront.ProductOption>{ get }
    var selectOptionAtIndexAction: AnyObserver<IndexPath>{ get }
}

//  Outputs
protocol ProductDetailViewModelOutputs {
    var atcTapped: Observable<Void> { get }
    var availableOptions: Observable<[Storefront.ProductOption]> { get }
    var selectedOption: Observable<Storefront.ProductOption> { get }
}

protocol ProductDetailViewModelTypes {
    var inputs: ProductDetailViewModelInputs { get }
    var outputs: ProductDetailViewModelOutputs { get }
}

/*************************************************/
//  Implementation
class ProductDetailViewModel: ProductDetailViewModelInputs, ProductDetailViewModelOutputs, ProductDetailViewModelTypes {
    
   var disposeBag = DisposeBag()
    var title : String
    var productImages: ProductImagesRowViewModel
    var productHeader: ProductHeaderRowViewModel
    var productVariants: ProductVariantsRowViewModel
    var productDescription: ProductDescriptionRowViewModel
    
    var productDetailSections: [TableCompatible]
    var datasource = Datasource()

    init(product: ProductModel) {
        productImages      = ProductImagesRowViewModel(product: product)
        productHeader      = ProductHeaderRowViewModel(product: product)
        productVariants    = ProductVariantsRowViewModel(product: product)
        productDescription = ProductDescriptionRowViewModel(product: product)
        
        productDetailSections = [productImages, productHeader, productVariants, productDescription]
        
        datasource.tableData = productDetailSections
        
        title = product.title
        
        _availableOptionsSubject = BehaviorSubject<[Storefront.ProductOption]>(value: product.options)
        
        productVariants.outputs.optionButtonTapped
        .bind(to: _selectedOptionSubject)
        .disposed(by: disposeBag)
        
       _selectedOptionIndexSubject
        .bind(to: productVariants.currentOptionValue)
        .disposed(by: disposeBag)
    }
    
    //  Subjects
    var atcSubject = PublishSubject<Void>()
    var _availableOptionsSubject: BehaviorSubject<[Storefront.ProductOption]>
    var _selectedOptionSubject = PublishSubject<Storefront.ProductOption>()
    var _selectedOptionIndexSubject = PublishSubject<IndexPath>()
    
    // Inputs
    var atcAction: AnyObserver<Void> {
        return atcSubject.asObserver()
    }
    var selectOptionAction: AnyObserver<Storefront.ProductOption>{
        return _selectedOptionSubject.asObserver()
    }
    
    var selectOptionAtIndexAction: AnyObserver<IndexPath>{
        return _selectedOptionIndexSubject.asObserver()
    }
    
    //  Outputs
    var atcTapped: Observable<Void> {
        return atcSubject.asObservable()
    }
    var availableOptions: Observable<[Storefront.ProductOption]>{
        return _availableOptionsSubject.asObservable()
    }
    
    var selectedOption: Observable<Storefront.ProductOption>{
        return _selectedOptionSubject.asObservable()
    }
    
    var inputs: ProductDetailViewModelInputs { return self }
    var outputs: ProductDetailViewModelOutputs { return self }
}
