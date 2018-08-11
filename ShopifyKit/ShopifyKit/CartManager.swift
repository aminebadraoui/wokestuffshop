//
//  CartManager.swift
//  ShopifyKit
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation

public class CartManager {
    
    public static let shared = CartManager()
    
    private(set) public var items: [CartItemModel] = []
    
    public func add(_ cartItem: CartItemModel) {
     
            self.items.append(cartItem)
        
    }

    
}
