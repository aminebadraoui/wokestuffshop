//
//  CollectionCardItemViewModel.swift
//  App
//
//  Created by Amine on 2018-07-08.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import ShopifyKit
import RxSwift
import Kingfisher

protocol CollectionCardItemViewModelInput {
    var selectProductAction: AnyObserver<ProductModel> { get }
}

protocol CollectionCardItemViewModelOutput {
    var cellTapped: Observable<Void> { get }
    var selectedProduct: Observable<ProductModel> { get }
    var datasourceOutput: Observable<Void> { get }
}

protocol CollectionCardItemViewModelType {
    var inputs: CollectionCardItemViewModelInput { get }
    var outputs: CollectionCardItemViewModelOutput { get }
}

class CollectionCardItemViewModel: CollectionCompatible, CollectionCardItemViewModelInput, CollectionCardItemViewModelOutput, CollectionCardItemViewModelType {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       collectionView.register(CollectionCardItem.self, forCellWithReuseIdentifier: "CollectionCardItem")
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCardItem", for: indexPath) as! CollectionCardItem
        
        collectionCell.configure(viewModel: self)
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         _cellTappedSubject.onNext(())
    }
    
    let client = Client.shared
    let disposeBag = DisposeBag()
    var datasource = Datasource()
    var collection: CollectionModel
    var products: [ProductItemViewModel] = []
    let imageUrl: URL?
    
    init(collection: CollectionModel){
        self.collection = collection
   
        if let collectionImageURL = collection.imageUrl  {
            imageUrl = collectionImageURL
        } else {
            imageUrl = collection.defaultImagURL
        }
    }
    
    func fetchProducts(limit: Int32 = 100) {
        
        let productsObservable = client.fetchProducts(in: collection, limit: limit).asObservable().share(replay: 1)
        
        productsObservable.observeOn(MainScheduler.instance)
            
            .subscribe(onNext: { productList in
                self.products = productList.map { product in
                    let cell = ProductItemViewModel(productModel: product)
                    
                    cell.outputs.cellTapped
                        .map{ _ in product }
                        .bind(to: self._selectedProductSubject)
                        .disposed(by: self.disposeBag)
                    return cell
                }
                
                self.datasource.collectionData = self.products
                
                if self.products.isEmpty {
                    self.datasource.collectionData = [EmptyProductItemViewModel()]
                }
                
            },
                       onCompleted: {
                        self._datasourceSubject.onNext(())
                        
            }).disposed(by: disposeBag)
    }
    
    // Subject
    private var _cellTappedSubject = PublishSubject<Void>()
   
    private var _selectedProductSubject = PublishSubject<ProductModel>()
    private var _selectedCollectionSubject = PublishSubject<CollectionModel>()
    private var _datasourceSubject = PublishSubject<Void>()
    //  Inputs
    var selectProductAction: AnyObserver<ProductModel> {
        return _selectedProductSubject.asObserver()
    }
    
    //  Outputs
    var cellTapped: Observable<Void> {
        return _cellTappedSubject.asObservable()
    }
    
    var datasourceOutput: Observable<Void> {
        return _datasourceSubject.asObservable()
    }
    
    var selectedProduct: Observable<ProductModel> {
        return _selectedProductSubject.asObservable()
    }
    
    var inputs: CollectionCardItemViewModelInput { return self }
    var outputs: CollectionCardItemViewModelOutput { return self }
  
    var height: CGFloat = 250
}
