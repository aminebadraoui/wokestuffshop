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
    let footerView: UIView
    let priceStackView: UIStackView
    let productTitle: UILabel
    let productPrice: UILabel
    let productCompareAtPrice: UILabel
    
    
    override init(frame: CGRect) {
        productImageView = UIImageView(frame: CGRect.zero)
        footerView = UIView(frame: CGRect.zero)
        priceStackView = UIStackView(frame: CGRect.zero)
        productTitle = UILabel(frame: CGRect.zero)
        productPrice = UILabel(frame: CGRect.zero)
        productCompareAtPrice = UILabel(frame: CGRect.zero)
        
        super.init(frame: frame)
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

        priceStackView.addArrangedSubview(productTitle)
        priceStackView.addArrangedSubview(productPrice)
        priceStackView.addArrangedSubview(productCompareAtPrice)
        priceStackView.axis = .vertical
        
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
        
        self.backgroundColor =  .white

        setupConstraints()
    }
    
    func setupConstraints() {
        self.addSubview(productImageView)
        productImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-100)
        })
        
        self.addSubview(footerView)
        footerView.snp.makeConstraints({
            $0.top.equalTo(productImageView.snp.bottom).offset(8)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        
        footerView.addSubview(priceStackView)
        priceStackView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            
        })
    }
}
