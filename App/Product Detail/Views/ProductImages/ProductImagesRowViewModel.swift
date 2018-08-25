//
//  ProductImagesRowViewModel.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
import RxSwift
import RxCocoa

class ProductImagesRowViewModel:  ProductDetailItem {
    var height: CGFloat = 416
    var product: ProductModel
    
    var type: ProductDetailViewModelType = .images
    var sectionTitle: String = "images"
    
    init(product: ProductModel){
        self.product = product
    }
    

    
    
}
