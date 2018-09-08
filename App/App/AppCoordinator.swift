//
//  AppCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    //  Properties
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
  

    var disposeBag =  DisposeBag()
    
    // Init
    
    init(){
        rootViewController = UIViewController()
    }
    
    // Start function
    func start()  {
      
        let wokeTabBarCoordinator = TabBarCoordinator()
        wokeTabBarCoordinator.start()
      
       rootViewController = wokeTabBarCoordinator.tabBarController
    }
    
    

}
