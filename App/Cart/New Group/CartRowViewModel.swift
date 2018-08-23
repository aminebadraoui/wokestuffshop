//
//  CartRowViewModel.swift
//  App
//
//  Created by Amine on 2018-08-11.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift

protocol CartRowViewModelInputs {
    var stepperTapAction: AnyObserver<Int> { get }
}

protocol CartRowViewModelOutputs {
    var productTitleView: Observable<String> { get }
    var variantTitleView: Observable<String> { get }
    var priceView: Observable<String> { get }
    var quantityView: Observable<String> { get }
    var imageUrl: Observable<URL?> { get }
    
    var tappedStepper: Observable<Int> { get }
}

protocol CartRowVIewModelTypes {
    var inputs: CartRowViewModelInputs { get }
    var outputs: CartRowViewModelOutputs { get }
}

class CartRowViewModel: CartRowViewModelInputs, CartRowViewModelOutputs, CartRowVIewModelTypes {
    let cartItem: CartItemModel
    
    init(cartItem: CartItemModel){
        self.cartItem = cartItem
        
        let cartItemObservable = Observable.of(cartItem).share(replay: 1)
        
        priceView = cartItemObservable
            .map {
                let totalPrice = ($0.variant.price) * Decimal($0.quantity)
                return Currency.stringFrom(totalPrice)
        }
        
        productTitleView = cartItemObservable
            .map{
                $0.product.title
        }
        
        quantityView = cartItemObservable
            .map {
                String($0.quantity)
        }
        
        variantTitleView = cartItemObservable
            .map {
                $0.variant.title
        }
        
        imageUrl = cartItemObservable
            .map {
                $0.product.images.first
        }
    }
    
    //  Subjects
    var _stepperTapSubject = PublishSubject<Int>()
    
    //  Inputs
    var stepperTapAction: AnyObserver<Int> {
        return _stepperTapSubject.asObserver()
    }
    
    //  Outputs
    var priceView: Observable<String>
    var productTitleView: Observable<String>
    var quantityView: Observable<String>
    var variantTitleView: Observable<String>
    var imageUrl: Observable<URL?>
    
    var tappedStepper: Observable<Int> {
        return _stepperTapSubject.asObservable()
    }
    
    var inputs: CartRowViewModelInputs { return self }
    var outputs: CartRowViewModelOutputs { return self }
    
}
