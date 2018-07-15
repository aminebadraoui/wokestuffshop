//
//  CollectionListCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class CollectionListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    var disposeBag = DisposeBag()
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
        
        
    }
    
    func start() {
        let collectionListVM = CollectionListVM()
        let vc = CollectionListVC(vm: collectionListVM)
        

        
        if let collectionNav = rootViewController as? UINavigationController {
            collectionNav.pushViewController(vc, animated: true)
        }
    }
 
    
    func coordinateToProduct(){
        
        let productCoordinator = ProductCoordinator(rootViewController: self.rootViewController)
        productCoordinator.start()
        
     
    }
}
