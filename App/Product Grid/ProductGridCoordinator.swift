//
//  ProductListCoordinator.swift
//  App
//
//  Created by Amine on 2018-07-14.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import ShopifyKit

class ProductGridCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    var viewModel : ProductGridViewModel!
    
    var collection: CollectionModel
    
    var disposeBag = DisposeBag()
    
    init(rootViewController: UIViewController, collection: CollectionModel){
        self.rootViewController = rootViewController
        self.collection = collection
    }
    
    func start() {
        viewModel = ProductGridViewModel(collection: collection)
        
        let vc = ProductGridViewController(vm: viewModel)
        if let productNav = rootViewController as? UINavigationController {
            let attrs = [
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
            productNav.navigationBar.titleTextAttributes = attrs
            productNav.setNeedsStatusBarAppearanceUpdate()
            productNav.navigationBar.tintColor = .white
            productNav.pushViewController(vc, animated: true)
        }
        
        viewModel.outputs.selectedProduct
            .subscribe(onNext: { product in
                self.coordinateToProductDetail(product: product)
            })
            .disposed(by: disposeBag)
    }
    
    func coordinateToProductDetail(product: ProductModel){
        let vc = ProductDetailViewController.make()
        if let nav = rootViewController as? UINavigationController {
            nav.pushViewController(vc, animated: true)
        }
        vc.title = product.title
    }
    
}

