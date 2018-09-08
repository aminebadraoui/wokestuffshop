//
//  ProductDetailItem.swift
//  App
//
//  Created by Amine on 2018-08-12.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation

protocol ProductDetailItem {
    var type: ProductDetailViewModelType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ProductDetailItem {
    var rowCount: Int {
        return 1
    }
}
