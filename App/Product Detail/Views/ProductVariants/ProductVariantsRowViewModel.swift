//
//  ProductVariantsRowViewModel.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
import RxSwift
import RxCocoa
import MobileBuySDK

protocol ProductVariantsRowViewModelInputs {
 var optionButtonTapAction: AnyObserver<Storefront.ProductOption> { get }
    var currentOptionValue: AnyObserver<IndexPath> { get }
}

protocol ProductVariantsRowViewModelOutputs {
    var optionsView: Observable<[Storefront.ProductOption]> { get }
    var optionButtonTapped: Observable<Storefront.ProductOption> { get }
    var currentSelectedOptionValue: Observable<IndexPath> { get }
}

protocol ProductVariantsRowViewModelTypes {
    var inputs: ProductVariantsRowViewModelInputs { get }
    var outputs: ProductVariantsRowViewModelOutputs { get }
}

class ProductVariantsRowViewModel: TableCompatible, ProductVariantsRowViewModelInputs, ProductVariantsRowViewModelOutputs, ProductVariantsRowViewModelTypes   {
    init(product: ProductModel){
        self.product = product
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: ProductVariantsCell.self)
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductVariantsCell.self)
        cell.configure(row: self)
        
        _optionsSubject.onNext(product.options)
        
        return cell
    }
    
    var height: CGFloat = UITableViewAutomaticDimension
    var product: ProductModel
    
    //  Subjects
    private var _optionsSubject = PublishSubject<[Storefront.ProductOption]>()
    private var _optionButtonTappedSubject = PublishSubject<Storefront.ProductOption>()
    private var _currentOptionValueSubject = BehaviorSubject<IndexPath>(value: [0,0])
    
    //  Inputs
    var optionButtonTapAction: AnyObserver<Storefront.ProductOption>{
        return _optionButtonTappedSubject.asObserver()
    }
    var currentOptionValue: AnyObserver<IndexPath>{
        return _currentOptionValueSubject.asObserver()
    }
    
    //  Outputs
    var optionsView: Observable<[Storefront.ProductOption]> {
        return _optionsSubject.asObservable()
    }
    var optionButtonTapped: Observable<Storefront.ProductOption>{
        return _optionButtonTappedSubject.asObservable()
    }
    var currentSelectedOptionValue: Observable<IndexPath>{
        return _currentOptionValueSubject.asObservable()
    }
    
    //  Types
    var inputs: ProductVariantsRowViewModelInputs { return self }
    var outputs: ProductVariantsRowViewModelOutputs{ return self }
}
