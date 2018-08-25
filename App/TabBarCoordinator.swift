//
//  MenuTabBarCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-09.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Rswift
import ShopifyKit

class TabBarCoordinator: Coordinator {
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
    
    let tabBarController = UITabBarController()
    
    var tabControllers: [UINavigationController] = []
 
    init() {
         rootViewController = UITabBarController()
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        collectionNav.navigationBar.titleTextAttributes = attrs
        collectionNav.setNeedsStatusBarAppearanceUpdate()
        
        cartNav.navigationBar.titleTextAttributes = attrs
        cartNav.setNeedsStatusBarAppearanceUpdate()
        
        homeNav.navigationBar.titleTextAttributes = attrs
        homeNav.setNeedsStatusBarAppearanceUpdate()
        
        homeNav.navigationBar.barTintColor = .black
        collectionNav.navigationBar.barTintColor = .black
        cartNav.navigationBar.barTintColor = .black
     
        childCoordinators = []
    }
    
    func start() {
        configureTabs()
        configureNavControllers()
        tabBarController.viewControllers = [homeNav,collectionNav,cartNav]
        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        
        rootViewController = tabBarController
        
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
        
        let homeCoordinator           = HomeCoordinator(rootViewController: homeNav)
        let collectionListCoordinator = CollectionListCoordinator(rootViewController: collectionNav)
        let cartCoordinator           = CartCoordinator(rootViewController: cartNav)
        
        homeCoordinator.start()
        
        collectionListCoordinator.start()
       
        cartCoordinator.start()
        
        homeNav.tabBarItem       = homeTab
        collectionNav.tabBarItem = collectionTab
        cartNav.tabBarItem       = cartTab
      
        cartNav.tabBarItem.badgeColor = .red
        
        CartManager.shared.totalQuantityObservable
            .subscribe(onNext: { quantity in
                guard quantity != 0 else { return self.cartNav.tabBarItem.badgeValue = nil }
         
            self.cartNav.tabBarItem.badgeValue = String(quantity)
        })
            .disposed(by: disposeBag)
 
    }
    
    
}
