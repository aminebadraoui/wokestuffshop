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
    var productListPreview = [ProductItemViewModel]()
    var cardsFlow = UICollectionViewFlowLayout()

    init(option: MenuOption) {
      self.option = option
    }
    
    func configureFlow() {
        let cardSizeDimension = UIScreen.main.bounds.width
        
        cardsFlow.scrollDirection         = .vertical
        cardsFlow.minimumInteritemSpacing = 0
        cardsFlow.minimumLineSpacing      = 0
        cardsFlow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        switch option.type {
        case .collectionFeed:
            cardsFlow.itemSize = CGSize(width: cardSizeDimension, height: cardSizeDimension + 250)
        case .productFeed:
            cardsFlow.itemSize = CGSize(width: cardSizeDimension, height: cardSizeDimension)
        }
    }
    
    func fetchProducts() {
        showLoaderSubject.onNext(())
        let productsObservable =
            client.fetchCollection(handle: option.handle ?? CollectionHandle.all.rawValue)
            .flatMap { collection in
                self.client.fetchProducts(in: collection) }
            .share(replay: 1)
        
        productsObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { productList in
                self.products = productList.map { product in
                    let cell = ProductCardItemViewModel(productModel: product)
                    
                    cell.outputs.cellTapped
                        .map{ _ in product }.debug("log - product tapped")
                        .bind(to: self._selectedProductSubject)
                        .disposed(by: self.disposeBag)
                    return cell
                }
                
                self.datasource.collectionData = self.products
                self._datasourceSubject.onNext(())
            },
                       onCompleted: {
                        self.hideLoaderSubject.onNext(())
            }).disposed(by: disposeBag)
    }
        

        func fetchCollections() {
            showLoaderSubject.onNext(())
            let collections = client.fetchCollections().asObservable().share(replay: 1)

            collections.observeOn(MainScheduler.instance)
                .subscribe(onNext: { collectionModelList in

                    self.collections = collectionModelList.map { collectionModel -> CollectionCardItemViewModel in

                        let row = CollectionCardItemViewModel(collection: collectionModel)

                        row.fetchProducts(limit: 10)
                    
                        row.outputs.selectedProduct
                            .bind(to: self._selectedProductSubject)
                            .disposed(by: self.disposeBag)
                        
                        row.outputs.cellTapped
                            .map{ _ in collectionModel }
                            .bind(to: self._selectedCollectionSubject)
                            .disposed(by: self.disposeBag)

                        return row

                    }
                },
                    onCompleted: {
                        self._datasourceSubject.onNext(())
                        self.datasource.collectionData = self.collections
                }).disposed(by: disposeBag)
    }
    
    func fetchCollectionPreview() {
        self.collections.forEach({ collection in
        })
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
    private var _fetchCollectionPreviewSubject = PublishSubject<Void>()
    private var _datasourceSubject = PublishSubject<Void>()
    
    var showLoaderSubject = PublishSubject<Void>()
    var hideLoaderSubject = PublishSubject<Void>()
    
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
