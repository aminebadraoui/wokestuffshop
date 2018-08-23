//
//  ProductListItemCell.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-12.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class ProductListItemCell: ASCellNode {
    
    let productImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        return imageNode
    }()
    
    let productName = ASTextNode()
    let productPrice = ASTextNode()
    let productOldPrice = ASTextNode()
    
    var viewModel : ProductListItemViewModel!
    
    func setup(vm: ProductListItemViewModel) {
        
        self.viewModel = vm
        //  Image Configuration
        self.productImageNode.url = viewModel.product.images.first
        
        let currentPrice = viewModel.product.variants.first?.price
        let compareAtPrice = viewModel.product.variants.first?.price ?? nil
        
        let currentPriceString = HelperMethods.priceFormatter(price: currentPrice)
        let compareAtPriceString = HelperMethods.priceFormatter(price: compareAtPrice)
        
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
        
        self.productName.attributedText = NSAttributedString(string: viewModel.product.title, attributes: productNameAttributes)
        self.productPrice.attributedText = NSAttributedString(string: currentPriceString, attributes: productPriceAttributes)
        self.productOldPrice.attributedText = NSAttributedString(string: compareAtPriceString, attributes: productOldPriceAttributes)
        
    }
    
    override init() {
        super.init()
        self.backgroundColor = .white
        //  Cell configuration
        
        let size = UIScreen.main.bounds.size.width/2 - 20
        self.style.preferredSize = CGSize(width: size, height: size+48)
        
        self.productName.maximumNumberOfLines = 3
        self.productPrice.maximumNumberOfLines = 2
        self.productOldPrice.maximumNumberOfLines = 2
        
        self.automaticallyManagesSubnodes = true
        self.style.flexGrow = 1.0
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let productStack = ASStackLayoutSpec.vertical()
        //  TODO: Move to constants
        let defaultInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let smallInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let zeroVerticalInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        
        //Image section
        let imageLayoutSpec = ASRatioLayoutSpec(ratio: 0.75, child: productImageNode)
        productStack.children?.append(imageLayoutSpec)
        
        //  ******************
        //  Footer section
        let productFooterStack = ASStackLayoutSpec.vertical()
        
        //  Product Name
        let productNameLayoutSpec = ASInsetLayoutSpec(insets: defaultInsets , child: productName)
        productFooterStack.children?.append(productNameLayoutSpec)
        
        //  Prices
        let productPriceStack = ASStackLayoutSpec.vertical()
        let productPriceLayoutSpec = ASInsetLayoutSpec(insets: zeroVerticalInsets, child: productPrice)
        let productOldPriceLayoutSpec = ASInsetLayoutSpec(insets: zeroVerticalInsets, child: productOldPrice)
        productPriceStack.children = [productPriceLayoutSpec,productOldPriceLayoutSpec]
        
        //  complete the footer
        productFooterStack.children?.append(productPriceStack)
        productFooterStack.alignItems = .start
        productFooterStack.verticalAlignment = .center
        
        /************/
        //  complete the stakc
        productStack.children?.append(productFooterStack)
        
        return productStack
        
    }
}
