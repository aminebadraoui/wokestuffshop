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
        
        if let productNav = rootViewController as? UINavigationController {
            productNav.pushViewController(vc, animated: true)
        }
        
        //  Tapped on option
        productDetailViewModel.outputs.selectedOption
            .subscribe(onNext: { selectedOption in
                self.coordinateToVariantScreen(option: selectedOption)
            }).disposed(by: disposeBag)
        
        //  Tapped on atc button
        productDetailViewModel.outputs.atcTapped.subscribe(onNext: { product in
            self.coordinateToCart(product: product)
        }).disposed(by: disposeBag)
    }
    
    //  Go to variant screen
    func coordinateToVariantScreen(option: OptionModel) {
        
        let productVariantCoordinator = ProductVariantCoordinator(rootViewController: rootViewController, option: option)
        productVariantCoordinator.start()
        
        productVariantCoordinator.optionListViewModel.outputs.selectedOptionValue
            .bind(to: productDetailViewModel.inputs.newOptionValue)
            .disposed(by: disposeBag)
        
    }
    
    //  TODO: REPLACE WITH CART COORDINATOR
    func coordinateToCart(product: ProductModel) {
        
        var selectedOptions : [Storefront.SelectedOptionInput] = []
        
        product.options.forEach {
            let option = Storefront.SelectedOptionInput.create(name: $0.name, value: $0.selectedValue)
            
            selectedOptions.append(option)
        }
        
        client.fetchVariantForOptions(in: self.product, for: selectedOptions)
            .subscribe(onNext: { variant in
                let item = CartItemModel(product: self.product, variant: variant)
                
                CartManager.shared.add(item)
            })
            .disposed(by: disposeBag)
    }
    
}
