//
//  HomeCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import ShopifyKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    var disposeBag = DisposeBag()
    func start() {
        let vm = HomeViewModel()
        let vc = HomeViewController(vm: vm)
        
        if let homeNav = rootViewController as? UINavigationController {
            homeNav.pushViewController(vc, animated: true)
        }
        
        vc.pager.browserViewControllers.forEach({
            $0.viewModel.selectedProduct
                .debug("log - Coordinator selected product")
                .bind(to: vm._selectedProduct)
                .disposed(by: disposeBag)
        })
        
        vm._selectedProduct
        .asObservable()
            .subscribe(onNext: { product in
                self.coordinateToProductDetail(product: product)
                
            })
        .disposed(by: disposeBag)
        
        
        vc.pager.browserViewControllers.forEach({
            $0.viewModel.selectedCollection
                .bind(to: vm._selectedCollection)
                .disposed(by: disposeBag)
        })
        
        vm._selectedCollection
            .asObservable()
            .subscribe(onNext: { collection in
                self.coordinateToCollection(collection: collection)
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func coordinateToCollection(collection: CollectionModel){
        let productGridCoordinator = ProductGridCoordinator(rootViewController: self.rootViewController, collection: collection)
        
        productGridCoordinator.start()
        
    }
    
    func coordinateToProductDetail(product: ProductModel){
        let productDetailCoordinator = ProductDetailCoordinator(rootViewController: self.rootViewController, product: product)
        
        productDetailCoordinator.start()
        
    }
}
