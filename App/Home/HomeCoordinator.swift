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
        let vm = HomeVM()
        let vc = HomeVC(vm: vm)
        
        if let homeNav = rootViewController as? UINavigationController {
            homeNav.pushViewController(vc, animated: true)
        }
        
        vm._selectedProduct
        .asObservable()
            .subscribe(onNext: { product in
                self.coordinateToProductDetail(product: product)
                
            })
        .disposed(by: disposeBag)
    }
    
    func coordinateToProductDetail(product: ProductModel){
        let productDetailCoordinator = ProductDetailCoordinator(rootViewController: self.rootViewController, product: product)
        
        productDetailCoordinator.start()
        
    }
}
