//
//  HomeCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = HomeViewController.make()
        if let homeNav = rootViewController as? UINavigationController {
            homeNav.pushViewController(vc, animated: true)
        }
    }
    
    

}
