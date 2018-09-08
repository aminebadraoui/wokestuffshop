//
//  CartViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift

protocol CartViewModelInputs {
    var updateQuantityAction: AnyObserver<(value: Int, indexPath: IndexPath)> { get }
    var removeItemAction: AnyObserver<IndexPath> { get }
}

protocol CartViewModelOutputs {
    var reloadView: Observable<Void> { get }
    var subtotalObservable: Observable<Decimal> { get }
    var checkoutBtnEnabled: Observable<Bool> { get }
}

protocol CartViewModelTypes {
    var inputs: CartViewModelInputs { get }
    var outputs: CartViewModelOutputs { get }
}

class CartViewModel: CartViewModelInputs, CartViewModelOutputs, CartViewModelTypes {
    var items: [CartRowViewModel] = []
    var disposeBag = DisposeBag()
    
    
    init() {
        
        let itemsObservable = CartManager.shared.itemsObservable.share(replay: 1)
        
        let subtotalObservable = CartManager.shared.subtotalObservable.share(replay: 1)
            
            itemsObservable
            .subscribe(onNext: {
                self.items = $0.map { CartRowViewModel(cartItem: $0)}
            })
            .disposed(by: disposeBag)
        
        _updateQuantitySubject.asObservable()
            .subscribe(onNext: { tuple in
                let quantity = tuple.value
                let index = tuple.indexPath
                CartManager.shared.updateQuantity(quantity, at: index)
            })
            
        .disposed(by: disposeBag)
        
        itemsObservable
            .map { _ in () }
            .bind(to: _reloadViewSubject)
            .disposed(by: disposeBag)
        
        itemsObservable
            .map { items in
                items.count != 0
        }.bind(to: _isCheckoutEnabledSubject)
        .disposed(by: disposeBag)
        
        subtotalObservable
            .bind(to: _subtotalSubject)
            .disposed(by: disposeBag)
        
        _removeItemSubject.subscribe(onNext: { index in
            CartManager.shared.removeItemAt(index)
        })
        .disposed(by: disposeBag)
        
        
    }
    
    //  Subjects
    var _updateQuantitySubject = PublishSubject<(value: Int, indexPath: IndexPath)>()
    var _reloadViewSubject = PublishSubject<Void>()
    var _subtotalSubject = BehaviorSubject<Decimal>(value: 0.0)
    var _removeItemSubject = PublishSubject<IndexPath>()
    var _isCheckoutEnabledSubject = BehaviorSubject<Bool>(value: false)
    
    //  Inputs
    var updateQuantityAction: AnyObserver<(value: Int, indexPath: IndexPath)> {
        return _updateQuantitySubject.asObserver()
    }
    var removeItemAction: AnyObserver<IndexPath>{
        return _removeItemSubject.asObserver()
    }
    
    //  Outputs
    var reloadView: Observable<Void>{
        return _reloadViewSubject
    }
    
    var subtotalObservable: Observable<Decimal> {
        return _subtotalSubject.asObservable()
    }
    
    var checkoutBtnEnabled: Observable<Bool> {
        return _isCheckoutEnabledSubject.asObservable()
    }
    
    var inputs: CartViewModelInputs { return self }
    var outputs: CartViewModelOutputs { return self }
}
