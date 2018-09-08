//
//  ProductItemCell.swift
//  App
//
//  Created by Amine on 2018-08-25.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ProductItemCell: UICollectionViewCell {
    
    var viewModel: ProductItemViewModel!
    
    let productImageView: UIImageView
    let productTitle: UILabel
    let productPrice: UILabel
    let productCompareAtPrice: UILabel
    
    override init(frame: CGRect) {
        productImageView = UIImageView(frame: CGRect.zero)
        productTitle = UILabel(frame: CGRect.zero)
        productPrice = UILabel(frame: CGRect.zero)
        productCompareAtPrice = UILabel(frame: CGRect.zero)
        
        super.init(frame: frame)
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ProductItemViewModel) {
       self.viewModel =  viewModel
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.kf.setImage(with: viewModel.product.images.first)
        
        productTitle.text = viewModel.productTitle
        productTitle.numberOfLines = 2
        productPrice.text = viewModel.productPrice
        productCompareAtPrice.text = viewModel.productCompareAtPrice
        
        //  Text Configuration
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let productNameAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productNameSize, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productPriceAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productPriceSize, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productPrice,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        let productOldPriceAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productOldPriceSize, ofType: .regular),
            NSAttributedStringKey.foregroundColor : AppColor.productOldPrice ,
            NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        self.productTitle.attributedText = NSAttributedString(string: viewModel.productTitle, attributes: productNameAttributes)
        self.productPrice.attributedText = NSAttributedString(string: viewModel.productPrice, attributes: productPriceAttributes)
        self.productCompareAtPrice.attributedText = NSAttributedString(string: viewModel.productCompareAtPrice, attributes: productOldPriceAttributes)
        
        self.backgroundColor =  AppColor.appBackground
    }
    
    func setupText() {
      
    }
    
    func setupConstraints() {
        self.addSubview(productImageView)
        productImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(150)
        })
        
        self.addSubview(productTitle)
        productTitle.snp.makeConstraints({
            $0.top.equalTo(productImageView.snp.bottom).offset(4)
            $0.width.equalToSuperview()
        })
        
        self.addSubview(productPrice)
        productPrice.snp.makeConstraints({
            $0.top.equalTo(productTitle.snp.bottom).offset(4)
            $0.width.equalToSuperview()
        })
        
        self.addSubview(productCompareAtPrice)
        productCompareAtPrice.snp.makeConstraints({
            $0.top.equalTo(productPrice.snp.bottom).offset(2)
            $0.width.equalToSuperview()
        })
    }
    
}
