//
//  Client.swift
//  ShopifyKit
//
//  Created by Amine on 2018-06-26.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK
import RxSwift

public class Client {
    
    //  TODO: REPLACE BY CONSTANTS
    static let _shopDomain = "wokestuff.myshopify.com"
    static let _apiKey     = "c8e9986eba5fb069b608792bd6a6cf58"
    
    public static let shared = Client()
    
    let client = Graph.Client(shopDomain: _shopDomain, apiKey: _apiKey)
    
    public init() {
        //self.client.cachePolicy = .cacheFirst(expireIn: 3600)
    }
    
    /************** Fetch All Collections *********/
    public func fetchCollections()-> Observable<[Collection]>  {
        return Observable.create { observer in
            var collectionList = [Collection]()
            
            let query = ClientQuery.queryForAllCollections()
            
            let response = self.client.queryGraphWith(query) { response, error in
                if let collections = response?.shop.collections.edges.map({ $0.node }) {
                    
                    collections.forEach { collectionList.append(Collection(from: $0)) }
                    observer.onNext(collectionList)
                }
            }
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
        
    }
    
    /************** Fetch products in collection *********/
    public func fetchProducts(in collection: Collection)-> Observable<[Product]>  {
        
        return Observable.create { observer in
            var productList = [Product]()

            let query = ClientQuery.queryForProducts(in: collection)
            
            let response = self.client.queryGraphWith(query) { query, error in
                
                if let query = query, let collection = query.node as? Storefront.Collection {
                    let products = collection.products.edges.map ( { $0.node })
                    
                    products.forEach { productList.append(Product(from: $0)) }
                    observer.onNext(productList)
                    print(productList.count)
                }
            }
            
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    /************** Fetch collection with handle *********/
    public func fetchCollection(handle: String)-> Observable<Collection>  {
        
        return Observable.create { observer in
            
            let query    = ClientQuery.queryForCollection(handle: handle)
            let response = self.client.queryGraphWith(query) { query, error in
                
                if let query = query, let collection = query.shop.collectionByHandle  {
                    let collectionModel = Collection(from: collection)
                    observer.onNext(collectionModel)
                    print(collectionModel.handle)
                }
            }
            
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
}
