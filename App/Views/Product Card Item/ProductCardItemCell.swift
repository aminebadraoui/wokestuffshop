//
//  ProductCardItemCell.swift
//  App
//
//  Created by Amine on 2018-08-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCardItemCell: UICollectionViewCell {
    
    var viewModel: ProductCardItemViewModel!
    
    let productImageView: UIImageView
    let priceFooterView: UIView
    let priceStackView: UIStackView
    let productTitle: UILabel
    let productPrice: UILabel
    let productCompareAtPrice: UILabel
    
    
    override init(frame: CGRect) {
        productImageView = UIImageView(frame: CGRect.zero)
        priceFooterView = UIView(frame: CGRect.zero)
        priceStackView = UIStackView(frame: CGRect.zero)
        productTitle = UILabel(frame: CGRect.zero)
        productPrice = UILabel(frame: CGRect.zero)
        productCompareAtPrice = UILabel(frame: CGRect.zero)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ProductCardItemViewModel) {
        self.viewModel =  viewModel
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.kf.setImage(with: viewModel.product.images.first)
        
        productTitle.numberOfLines = 2

        self.productTitle.attributedText = viewModel.productTitleAttributed
        self.productPrice.attributedText = viewModel.productPriceBlock
        //self.productCompareAtPrice.attributedText = NSAttributedString(string: viewModel.productCompareAtPrice, attributes: productOldPriceAttributes)
        
//        self.backgroundColor =  AppColor.appBackground
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: -3, height: 3)
//        self.layer.shadowOpacity = 0.7
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        self.addSubview(productImageView)
        productImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalToSuperview().offset(-80)
        })
        
        self.addSubview(productTitle)
        productTitle.snp.makeConstraints({
            $0.top.equalTo(productImageView.snp.bottom).offset(8)
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
        })
        
        self.addSubview(priceFooterView)
        priceFooterView.snp.makeConstraints({
            $0.top.equalTo(productTitle.snp.bottom).offset(4)
            $0.width.equalToSuperview()
        })
        
        priceFooterView.addSubview(productPrice)
        productPrice.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
        })
    }
}
