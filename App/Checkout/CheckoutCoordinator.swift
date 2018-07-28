//
//  CheckoutCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

class CheckoutCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = ProductDetailViewController.make()
        if let checkoutNav = rootViewController as? UINavigationController {
            checkoutNav.pushViewController(vc, animated: true)
        }
    }
}
