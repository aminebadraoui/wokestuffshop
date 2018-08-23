//
//  ProductVariantCoordinator.swift
//  App
//
//  Created by Amine on 2018-08-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import ShopifyKit
import MobileBuySDK

class ProductVariantCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    
    var optionListViewModel: OptionListViewModel!
    
    var option: OptionModel
    var disposeBag = DisposeBag()
    init(rootViewController: UIViewController, option: OptionModel){
        self.rootViewController = rootViewController
        self.option = option
    }
    
    func start() {
        
        optionListViewModel = OptionListViewModel(option: option)
        
        let optionListViewController = OptionListViewController.make(viewModel: optionListViewModel)
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        
        
        if let optionListNav = rootViewController as? UINavigationController {
            optionListNav.view.layer.add(transition, forKey: kCATransition)
            optionListNav.pushViewController(optionListViewController, animated: false)
            
            let attrs = [
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
            
            optionListNav.navigationBar.titleTextAttributes = attrs
            optionListNav.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}
