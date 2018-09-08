//
//  HomeBrowserViewModel.swift
//  App
//
//  Created by Amine on 2018-08-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//


import Foundation
import ShopifyKit
import RxSwift
import RxCocoa

protocol HomeBrowserViewModelInput {
    var selectProductAction: AnyObserver<ProductModel> { get }
}
protocol HomeBrowserViewModelOutput {
    var selectedProduct: Observable<ProductModel> { get }
    var datasourceOutput: Observable<Void> { get }
}

protocol HomeBrowserViewModelType {
    var output: HomeBrowserViewModelOutput { get }
    var input: HomeBrowserViewModelInput{ get }
}

class HomeBrowserViewModel: HomeBrowserViewModelInput, HomeBrowserViewModelOutput, HomeBrowserViewModelType {
 
    let client = Client.shared
    
    let disposeBag = DisposeBag()
    
    let option: MenuOption
    var datasource = Datasource()
    var products = [ProductCardItemViewModel]()
    var collections = [CollectionCardItemViewModel]()
    var cardsFlow = UICollectionViewFlowLayout()

    init(option: MenuOption) {
      self.option = option
    }
    
    func configureFlow() {
        let cardSizeDimension = UIScreen.main.bounds.width - 16
        
        cardsFlow.scrollDirection         = .vertical
        cardsFlow.minimumInteritemSpacing = 1
        cardsFlow.minimumLineSpacing      = 24
        cardsFlow.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        
        switch option.type {
        case .collectionFeed:
            cardsFlow.itemSize = CGSize(width: cardSizeDimension, height: cardSizeDimension/2)
        case .productFeed:
            cardsFlow.itemSize = CGSize(width: cardSizeDimension, height: cardSizeDimension)
        }
        
    }
    
    func fetchProducts() {
        let productsObservable =
            client.fetchCollection(handle: option.handle ?? CollectionHandle.all.rawValue)
            .flatMap { collection in
                self.client.fetchProducts(in: collection) }
            .share(replay: 1)
        
        let cellDisposeBag = DisposeBag()
        
        productsObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { productList in
                self.products = productList.map { product in
                    let cell = ProductCardItemViewModel(productModel: product)
                    
                    cell.outputs.cellTapped
                        .map{ _ in product }
                        .bind(to: self._selectedProductSubject)
                        .disposed(by: cellDisposeBag)
                    return cell
                }
                
                self.datasource.collectionData = self.products
                self._datasourceSubject.onNext(())
                
            }).disposed(by: disposeBag)
    }
        

        func fetchCollections() {
            
            let collections = client.fetchCollections().asObservable().share(replay: 1)

            collections.observeOn(MainScheduler.instance)
                .subscribe(onNext: { collectionModelList in

                    self.collections = collectionModelList.map { collectionModel -> CollectionCardItemViewModel in

                        let row = CollectionCardItemViewModel(collection: collectionModel)

                        row.outputs.cellTapped
                            .map{ _ in collectionModel }
                            .bind(to: self._selectedCollectionSubject)
                            .disposed(by: self.disposeBag)

                        return row

                    }

                    self.datasource.collectionData = self.collections
                    self._datasourceSubject.onNext(())
                    
                }).disposed(by: disposeBag)
        }
    
    func fetchFeed() {
        switch option.type {
        case .productFeed:
            fetchProducts()
            
        case .collectionFeed:
            fetchCollections()
        }
    }
     
    //  Subjects
    private var _selectedProductSubject = PublishSubject<ProductModel>()
    private var _selectedCollectionSubject = PublishSubject<CollectionModel>()
    private var _datasourceSubject = PublishSubject<Void>()
    
    //  Inputs
    var selectProductAction: AnyObserver<ProductModel> {
        return _selectedProductSubject.asObserver()
    }
    
    //  Outputs
    var selectedProduct: Observable<ProductModel> {
        return _selectedProductSubject.asObservable()
    }
    
    var selectedCollection: Observable<CollectionModel> {
        return _selectedCollectionSubject.asObservable()
    }
    
    var datasourceOutput: Observable<Void> {
        return _datasourceSubject.asObservable()
    }
    
    var output: HomeBrowserViewModelOutput { return self }
    var input: HomeBrowserViewModelInput { return self }
    
}
