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
            productNav.pushViewController(vc, animated: true)
        }
    }
    
    func coordinateToCart() {
        
        let vc = CartViewController.make()
        if let productNav = rootViewController as? UINavigationController {
            productNav.pushViewController(vc, animated: true)
        }
    }
}

