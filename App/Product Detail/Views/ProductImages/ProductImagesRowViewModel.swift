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

class ProductImagesRowViewModel: TableCompatible {
    var height: CGFloat = 450
    var product: ProductModel
    
    init(product: ProductModel){
        self.product = product
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: ProductImagesCell.self)
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductImagesCell.self)
        cell.configure(product: product)
        return cell
    }
    
    
}
