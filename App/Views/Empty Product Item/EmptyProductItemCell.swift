//
//  EmptyProductItemCell.swift
//  App
//
//  Created by Amine Badraoui on 2018-09-09.
//  Copyright © 2018 Amine Badraoui. All rights reserved.
//

import ShopifyKit
import RxSwift

class EmptyProductItemCell: UICollectionViewCell {
    
    var viewModel: EmptyProductItemViewModel!
    let productTitle: UILabel
    
    override init(frame: CGRect) {

        productTitle = UILabel(frame: CGRect.zero)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: EmptyProductItemViewModel) {
        self.viewModel =  viewModel
        
        productTitle.text = viewModel.productTitle
        productTitle.numberOfLines = 2

        
        //  Text Configuration
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let productNameAttributes = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productNameSize, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor,
            NSAttributedStringKey.paragraphStyle : paragraphStyle
        ]
        
        self.productTitle.attributedText = NSAttributedString(string: viewModel.productTitle, attributes: productNameAttributes)

        self.backgroundColor =  .white
        
        setupConstraints()
    }
    
    func setupConstraints() {
        self.addSubview(productTitle)
        productTitle.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
        })
    }
}
