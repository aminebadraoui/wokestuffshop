//
//  ProductDetailCoordinator.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import ShopifyKit
import MobileBuySDK

class ProductDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    var product: ProductModel
    
    let client = Client.shared
    
    // View Models
    var productDetailViewModel: ProductDetailViewModel!
    var optionListViewModel: OptionListViewModel!
    
    var disposeBag = DisposeBag()
    init(rootViewController: UIViewController, product: ProductModel){
        self.rootViewController = rootViewController
        self.product = product
    }
    
    func start() {
        
        productDetailViewModel = ProductDetailViewModel(product: self.product)
        let vc = ProductDetailViewController.instantiate(viewModel: productDetailViewModel)
        
        productDetailViewModel.outputs.atcTapped.subscribe(onNext: { _ in
            self.coordinateToCart()
        }).disposed(by: disposeBag)
        
        if let productNav = rootViewController as? UINavigationController {
            productNav.pushViewController(vc, animated: true)
        }
        
        productDetailViewModel.outputs.selectedOption.subscribe(onNext: { selectedOption in
            self.coordinateToVariantScreen(option: selectedOption)
        }).disposed(by: disposeBag)
    }
    
    //  TODO: REPLACE WITH VARIANT COORDINATOR
    func coordinateToVariantScreen(option: Storefront.ProductOption) {
        optionListViewModel = OptionListViewModel(option: option)
        let optionListViewController = OptionListViewController.make(viewModel: optionListViewModel)
        
        if let optionListNav = rootViewController as? UINavigationController {
            optionListNav.pushViewController(optionListViewController, animated: true)
            
            let attrs = [
                NSAttributedStringKey.foregroundColor: UIColor.white
            ]
            
            optionListNav.navigationBar.titleTextAttributes = attrs
            optionListNav.setNeedsStatusBarAppearanceUpdate()
        }
        
        optionListViewModel.outputs.selectedOptionValue
            .bind(to: productDetailViewModel.inputs.selectOptionAtIndexAction)
            .disposed(by: disposeBag)
    }
    
    //  TODO: REPLACE WITH CART COORDINATOR
    func coordinateToCart() {
        //self.product.varia
        var selectedOptions : [Storefront.SelectedOptionInput] = []
        
//        let option1 = Storefront.SelectedOptionInput.create(name: "Color", value: "Black")
//        selectedOptions.append(option1)
//        let option2 = Storefront.SelectedOptionInput.create(name: "Size", value: "L")
//        selectedOptions.append(option2)
        
      client.fetchVariantForOptions(in: self.product, for: selectedOptions).debug()
            .subscribe(onNext: { variant in
        }).disposed(by: disposeBag)
        
    let item = CartItemModel(product: self.product, variant: VariantModel(from: (self.product.variants.first?.node)!))
    
    CartManager.shared.add(item)
    
    let vc = CartViewController.make()
    if let productNav = self.rootViewController as? UINavigationController {
        productNav.pushViewController(vc, animated: true)
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        productNav.navigationBar.titleTextAttributes = attrs
        productNav.setNeedsStatusBarAppearanceUpdate()
    }
}

}
