//
//  CollectionCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class CollectionCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    var disposeBag = DisposeBag()
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
        
        
    }
    
    func start() {
        
        let vc = CollectionViewController.make()
        
        vc.didTap.subscribe(onNext: { _ in
            print("coordinate to product next")
            self.coordinateToProduct()
        },
                            onCompleted: { 
                                print("coordinate to product complete")
        },
                            onDisposed: {
                                print("coordinate to product dispose")
        }).disposed(by: disposeBag)
        
        if let collectionNav = rootViewController as? UINavigationController {
            collectionNav.pushViewController(vc, animated: true)
        }
    }
 
    
    func coordinateToProduct(){
        
        let productCoordinator = ProductCoordinator(rootViewController: self.rootViewController)
        productCoordinator.start()
        
     
    }
}
