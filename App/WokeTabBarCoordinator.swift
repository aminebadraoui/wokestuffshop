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
        homeNav.navigationBar.barTintColor = .black
        collectionNav.navigationBar.barTintColor = .black
        childCoordinators = []
        
        
    }
    
    func start() {
        
        
        configureTabs()
        configureNavControllers()
        wokeTabBarController.viewControllers = [homeNav,collectionNav,cartNav]
        wokeTabBarController.viewControllers?.forEach { $0.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]}
        wokeTabBarController.tabBar.barTintColor = .black
        wokeTabBarController.tabBar.tintColor = .white
        
        rootViewController = wokeTabBarController
        
        }
    

    
    private func configureTabs() {
        
        homeTab.title       = "Home"
        homeTab.image       = R.image.ic_home()

        collectionTab.title = "Collections"
        collectionTab.image = R.image.ic_apps()

        cartTab.title       = "Your Cart"
        cartTab.image       = R.image.ic_shopping_cart()
        
    }
    
    
    private func configureNavControllers() {
        
        let homeCoordinator       = HomeCoordinator(rootViewController: homeNav)
        let collectionCoordinator = CollectionListCoordinator(rootViewController: collectionNav)
        let cartCoordinator       = CartCoordinator(rootViewController: cartNav)
        
        homeCoordinator.start()
        collectionCoordinator.start()
        cartCoordinator.start()
        
        homeNav.tabBarItem       = homeTab
        collectionNav.tabBarItem = collectionTab
        cartNav.tabBarItem       = cartTab
      
 
    }
    
    
}
