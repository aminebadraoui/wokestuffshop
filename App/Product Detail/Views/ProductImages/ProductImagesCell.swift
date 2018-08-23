//
//  ProductImagesCell.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import ShopifyKit

class ProductImagesCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var containerView: UIView!
    let pageViewController = ImagesPageViewController()
    var viewModel: ProductImagesRowViewModel!
    
    func configure(row: ProductImagesRowViewModel) {
        self.viewModel = row
        pageViewController.imagesUrls = row.product.images
        
        self.containerView.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func awakeFromNib() {
    
    }
}
