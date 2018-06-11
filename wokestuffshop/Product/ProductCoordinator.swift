//
//  ProductCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class ProductCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    var disposeBag = DisposeBag()
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = ProductViewController.make()
        vc.showCart.subscribe(onNext: { _ in
            print("next event on showcart")
            self.coordinateToCart()
        }, onCompleted: {
            print("completed")
        },
           onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
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
