//
//  WokeTabBarController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-09.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Rswift
 

class WokeTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var rootViewController: UIViewController
    

    var disposeBag = DisposeBag()
    
    //Tabs corresponding to each navigation controller
    let homeTab = UITabBarItem()
    let collectionTab = UITabBarItem()
    let cartTab = UITabBarItem()
    
    let homeNav = UINavigationController()
    let collectionNav = UINavigationController()
    let cartNav = UINavigationController()
    
    let wokeTabBarController = UITabBarController()
    
    var tabControllers: [UINavigationController] = []
 
    init() {
        rootViewController = UITabBarController()
        childCoordinators = []
    }
    
    func start() {
        
        
        configureTabs()
        configureNavControllers()
        wokeTabBarController.viewControllers = [homeNav,collectionNav,cartNav]
        
        rootViewController = wokeTabBarController
        
        }
    

    
    private func configureTabs() {
        
        // Tabs titles
        homeTab.title = "Home"
        collectionTab.title = "Collections"
        cartTab.title = "Your Cart"
        
        // TODO: Tabs images
        
        // TODO: Tabs selected images
    }
    
    
    private func configureNavControllers() {
        
        let homeCoordinator = HomeCoordinator(rootViewController: homeNav)
        let collectionCoordinator = CollectionCoordinator(rootViewController: collectionNav)
        let cartCoordinator = CartCoordinator(rootViewController: cartNav)
        
        homeCoordinator.start()
        collectionCoordinator.start()
        cartCoordinator.start()
        
        homeNav.tabBarItem = homeTab
        collectionNav.tabBarItem = collectionTab
        cartNav.tabBarItem = cartTab

    }
    
    
}
