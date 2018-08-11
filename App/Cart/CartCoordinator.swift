//
//  CartCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class CartCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = CartViewController.make()
        if let cartNav = rootViewController as? UINavigationController {
            cartNav.pushViewController(vc, animated: true)
        }
    }
}

