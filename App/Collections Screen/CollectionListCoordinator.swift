//
//  CollectionListCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
import RxSwift

enum CollectionListCoordinationResult {
    case Collection(CollectionModel)
}

class CollectionListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    var  collectionListVM = CollectionListViewModel()
    
    var disposeBag = DisposeBag()
    
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = CollectionListViewController(vm: collectionListVM)
   
        if let collectionNav = rootViewController as? UINavigationController {
            collectionNav.pushViewController(vc, animated: true)
        }
        
       collectionListVM.outputs.selectedCollection
        .subscribe(onNext: { collection in
            self.displayProducts(in: collection)
        }).disposed(by: disposeBag)
    }
 
    private func displayProducts( in collection: CollectionModel ) {
        let productListCoordinator = ProductGridCoordinator(rootViewController: self.rootViewController, collection: collection)
        
        productListCoordinator.start()
    }
    
  
        
    
        
     

}
