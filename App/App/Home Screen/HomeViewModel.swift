//
//  HomeViewModel.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import ShopifyKit
import RxSwift

struct MenuOption {
    var handle: String?
    var title: String
    var type: FeedType
    
    init(handle: String? = nil, title: String, type: FeedType) {
        self.handle = handle ?? ""
        self.title = title
        self.type = type
    }
}

enum FeedType {
    case productFeed
    case collectionFeed
}

protocol HomeViewModelInputs {
    var optionIndex: AnyObserver<Int> { get }
}
protocol HomeViewModelOutputs {
    var datasourceOutput: Observable<Void> { get }
    var menuOptions: [MenuOption]{ get }
}

protocol HomeViewModelType {
    var outputs: HomeViewModelOutputs { get }
    var inputs: HomeViewModelInputs { get }
}

class HomeViewModel: HomeViewModelInputs, HomeViewModelOutputs, HomeViewModelType  {
    
    let disposeBag = DisposeBag()
    
    var dataSource = Datasource()
    
    let client = Client.shared
    
    var _selectedProduct = PublishSubject<ProductModel>()
    var _selectedCollection = PublishSubject<CollectionModel>()
    
    init() {
        
        let catalog = MenuOption(title: "Catalog", type: .collectionFeed)
        let bestsellers = MenuOption(handle: CollectionHandle.all.rawValue, title: "Bestsellers", type: .productFeed)
        let newest = MenuOption(handle: CollectionHandle.automotive.rawValue, title: "Newest", type:   .productFeed)
        let sales = MenuOption(handle: CollectionHandle.sale.rawValue, title: "On Sale", type:   .productFeed)
        
        let options = [catalog,bestsellers, newest, sales]
        
        menuOptions = options
        
    }
    
    private var _datasourceSubject = PublishSubject<Void>()
    private var _optionIndex = PublishSubject<Int>()
    
    //  Inputs
    var optionIndex: AnyObserver<Int> {
        return _optionIndex.asObserver()
    }
    
    //  Outputs
    var datasourceOutput: Observable<Void> {
        return _datasourceSubject.asObservable()
    }
    
    var menuOptions: [MenuOption]
    
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }
    
}
