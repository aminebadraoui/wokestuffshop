//
//  CartManager.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class CartManager {
    
    public static let shared = CartManager()
    
    private(set) public var items: [CartItemModel] = []
    
    public var itemsObservable = BehaviorSubject<[CartItemModel]>(value: [])
    public var subtotalObservable = BehaviorSubject<Decimal>(value: 0.0)
    
    var disposeBag = DisposeBag()
    
    init() {
        itemsObservable.map { _ in
            return self.computeSubtotal()
        }
        .bind(to: subtotalObservable)
        .disposed(by: disposeBag)
    }
    
    public func add(_ cartItem: CartItemModel) {
        //  Check if cart is empty or item doesn't already exist
        if items.count == 0 || !items.contains(where: { (item) -> Bool in
            cartItem.variant.id == item.variant.id })  {
            self.items.append(cartItem)
        }
        //  If item already exists then just increase quantity
        else {
            let index = items.index { (item) -> Bool in
                cartItem.variant.id == item.variant.id
            }
            
            items[index!].quantity += 1
        }
      
        itemsObservable.onNext(items)
    }
    
    public func updateQuantity(_ quantity: Int, at indexPath: IndexPath) {
        items[indexPath.row].quantity = quantity
        itemsObservable.onNext(items)
    }
    
    public func removeItemAt(_ indexPath: IndexPath){
        items.remove(at: indexPath.row)
        itemsObservable.onNext(items)
    }
    
    private func computeSubtotal()-> Decimal {
        let subtotal = items.map { ($0.variant.price) * Decimal($0.quantity)}.reduce(0,+)
        return subtotal
    }
    
}
