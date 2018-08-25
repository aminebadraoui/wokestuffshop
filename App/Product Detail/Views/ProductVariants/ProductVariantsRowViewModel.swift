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
    var option: AnyObserver<OptionModel> { get }
    var selectOptionAction: AnyObserver<Int> { get }
}

protocol ProductVariantsRowViewModelOutputs {
    var optionTitle: Observable<String> { get }
    var optionValue: Observable<String> { get }
    var selectedOption: Observable<Int> { get }
    
}

protocol ProductVariantsRowViewModelTypes {
    var inputs: ProductVariantsRowViewModelInputs { get }
    var outputs: ProductVariantsRowViewModelOutputs { get }
}

class ProductVariantsRowViewModel:
    ProductDetailItem,
    ProductVariantsRowViewModelInputs,
    ProductVariantsRowViewModelOutputs,
ProductVariantsRowViewModelTypes   {
    
    var rowCount: Int
    var sectionTitle: String = "Variants"
    var type: ProductDetailViewModelType = .variants
    
    
    init(product: ProductModel){
        self.product = product
        
        height = UITableViewAutomaticDimension
        rowCount = product.options.count
       
        optionTitle = _currentOptionSubject.asObservable().debug()
            .map {
                return $0.name
        }
        
        optionValue = _currentOptionSubject.asObservable().debug()
            .map {
                return $0.selectedValue
        }
    }
    
    // Subjects
    private var _selectOptionSubject =  PublishSubject<Int>()
    private var _currentOptionSubject = PublishSubject<OptionModel>()
    
    // Inputs
    var selectOptionAction: AnyObserver<Int>{
        return _selectOptionSubject.asObserver()
    }
    
    var option: AnyObserver<OptionModel> {
        return _currentOptionSubject.asObserver()
    }
    
    // outputs
    var selectedOption: Observable<Int> {
        return _selectOptionSubject.asObservable()
    }
    
    var optionTitle: Observable<String>
    var optionValue: Observable<String>
    
    var height: CGFloat
    
    var product: ProductModel
    
    //  Types
    var inputs: ProductVariantsRowViewModelInputs { return self }
    var outputs: ProductVariantsRowViewModelOutputs{ return self }
}
