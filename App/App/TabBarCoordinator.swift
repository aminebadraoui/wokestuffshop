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
    let cartTab = UITabBarItem()
    
    let homeNav = UINavigationController()
    let cartNav = UINavigationController()
    
    let tabBarController = UITabBarController()
    
    var tabControllers: [UINavigationController] = []
 
    init() {
         rootViewController = UITabBarController()
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        homeNav.navigationBar.titleTextAttributes = attrs
        homeNav.setNeedsStatusBarAppearanceUpdate()
        
        cartNav.navigationBar.titleTextAttributes = attrs
        cartNav.setNeedsStatusBarAppearanceUpdate()
        
        homeNav.navigationBar.barTintColor = UIColor.black
        homeNav.navigationBar.isTranslucent = false
        
        cartNav.navigationBar.barTintColor = .black
        cartNav.navigationBar.isTranslucent = false
     
        childCoordinators = []
    }
    
    func start() {
        configureTabs()
        configureNavControllers()
        tabBarController.viewControllers = [homeNav,cartNav]
        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .white
        
        rootViewController = tabBarController
        
        }
    
    private func configureTabs() {
        
        homeTab.title       = "Home"
        homeTab.image       = R.image.ic_home()

        cartTab.title       = "Your Cart"
        cartTab.image       = R.image.ic_shopping_cart()
        
    }
    
    private func configureNavControllers() {
        
        let homeCoordinator           = HomeCoordinator(rootViewController: homeNav)
        let cartCoordinator           = CartCoordinator(rootViewController: cartNav)
        
        homeCoordinator.start()
       
        cartCoordinator.start()
        
        homeNav.tabBarItem       = homeTab
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
