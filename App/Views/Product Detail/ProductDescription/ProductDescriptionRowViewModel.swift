//
//  ProductDescriptionRowViewModel.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
import RxSwift
import RxCocoa

protocol ProductDescriptionRowViewModelInputs {
    
}

protocol ProductDescriptionRowViewModelOutputs {
    var productDescription: Observable<String> { get }
}

protocol ProductDescriptionRowViewModelTypes {
    var inputs: ProductDescriptionRowViewModelInputs { get }
    var outputs: ProductDescriptionRowViewModelOutputs { get }
}

class ProductDescriptionRowViewModel: 
ProductDetailItem,
ProductDescriptionRowViewModelInputs,
ProductDescriptionRowViewModelOutputs,
ProductDescriptionRowViewModelTypes   {
    
    var disposeBag = DisposeBag()
    
    var type: ProductDetailViewModelType = .description
    var sectionTitle: String = "Description"
    
    
    /******************************/
    //  MARK: Initialization
    init(product: ProductModel){
        self.product = product
    }
    
    /******************************/
    //  MARK: Variables
    
    var height: CGFloat = UITableViewAutomaticDimension
     var product: ProductModel
    
    //  Subjects
    private var _productDescriptionSubject = PublishSubject<String>()

    //  Outputs
    var productDescription: Observable<String> {
        return _productDescriptionSubject.asObservable()
    }
    
    //  Type
    var inputs: ProductDescriptionRowViewModelInputs { return self }
    var outputs: ProductDescriptionRowViewModelOutputs { return self }
    
}
