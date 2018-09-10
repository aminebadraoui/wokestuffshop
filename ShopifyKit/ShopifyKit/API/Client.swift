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

public enum CollectionSortKey: String {
    case besteller = "bestseller"
    case newest = "newest"
}

public class Client {
    
    //  TODO: REPLACE BY CONSTANTS
    static let _shopDomain = "wokestuff.myshopify.com"
    static let _apiKey     = "c8e9986eba5fb069b608792bd6a6cf58"
    
    public static let shared = Client()
    
    let client = Graph.Client(shopDomain: _shopDomain, apiKey: _apiKey)
    
    public init() {
        //self.client.cachePolicy = .cacheFirst(expireIn: 3600)
    }
    
    // ----------------------------------
    //  MARK: - All collections -
    //
    public func fetchCollections()-> Observable<[CollectionModel]>  {
        
        return Observable.create { observer in
            var collectionList = [CollectionModel]()
            
            let query = ClientQuery.queryForAllCollections()
            
            let response = self.client.queryGraphWith(query) { response, error in
                
                DispatchQueue.main.async {
                    if let collections = response?.shop.collections.edges.map({ $0.node }) {
                        
                        collections.forEach { collectionList.append(CollectionModel(from: $0)) }
                        observer.onNext(collectionList)
                        observer.onCompleted()
                    }
                }
                
            }
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
        
    }
    
    // ----------------------------------
    //  MARK: - Products of collection -
    //
    public func fetchProducts(in collection: CollectionModel, sortKey: CollectionSortKey? = nil, limit: Int32 = 10)-> Observable<[ProductModel]>  {
        
        return Observable.create { observer in
            var productList = [ProductModel]()
            
            let query = ClientQuery.queryForProducts(in: collection, sortKey: sortKey, limit: limit)
            
            let response = self.client.queryGraphWith(query) { response, error in
                
                DispatchQueue.main.async {
                     let collection = response?.node as? Storefront.Collection
                    let products = collection?.products.edges.map ( { $0.node })
                        
                    products?.forEach { productList.append(ProductModel(from: $0)) }
                        observer.onNext(productList)
                        print("product fetch count \(productList.count)")
                        observer.onCompleted()
                       
                    
                }
            }
            
            response.resume()
            
            return Disposables.create {
                response.cancel()
                observer.onCompleted()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Collection from handle -
    //
    public func fetchCollection(handle: String)-> Observable<CollectionModel>  {
        
        return Observable.create { observer in
            
            let query    = ClientQuery.queryForCollection(handle: handle)
            let response = self.client.queryGraphWith(query) { query, error in
                
                DispatchQueue.main.async {
                    if let query = query, let collection = query.shop.collectionByHandle  {
                        let collectionModel = CollectionModel(from: collection)
                        observer.onNext(collectionModel)
                        observer.onCompleted()
                    }
                }
            }
            
            response.resume()
           
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Options of product -
    //
    public func fetchOptions(in product: ProductModel)-> Observable<[OptionModel]>  {
        
        return Observable.create { observer in
            
            let query    = ClientQuery.queryForOptionsInProduct(in: product)
            let response = self.client.queryGraphWith(query) { query, error in
                
                DispatchQueue.main.async {
                    if let query = query, let product = query.shop.productByHandle  {
                        let productOptions = product.options.map { OptionModel(from: $0) }
                        observer.onNext(productOptions)
                    }
                }
            }
            
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Variant by option selection-
    //
    public func fetchVariantForOptions(in product: ProductModel, for options: [Storefront.SelectedOptionInput])-> Observable<VariantModel>  {
        
        return Observable.create { observer in
            
            let query    = ClientQuery.queryForVariant(in: product, selectedOptions: options)
            let response = self.client.queryGraphWith(query) { query, error in
                
                DispatchQueue.main.async {
                    if let query = query, let variant = query.shop.productByHandle?.variantBySelectedOptions  {
                        let variantModel = VariantModel(from: variant)
                        observer.onNext(variantModel)
                    }
                }
            }
            
            response.resume()
            
            return Disposables.create {
                response.cancel()
            }
        }
    }
    
    
    // ----------------------------------
    //  MARK: - Checkout -
    //
    public func createCheckout(with cartItems: [CartItemModel], completion: @escaping (CheckoutModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForCreateCheckout(with: cartItems)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
           
            completion(CheckoutModel(from: (response?.checkoutCreate?.checkout)! ))
        }
        
        task.resume()
        return task
    }
}
