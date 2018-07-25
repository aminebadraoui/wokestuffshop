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
    
    //  Text Configuration

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    let productNameAttributes = [
        NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productNameSize, ofType: .regular),
        NSAttributedStringKey.foregroundColor : AppColor.defaultColor,
        NSAttributedStringKey.paragraphStyle : paragraphStyle
    ]
    
    let productPriceAttributes = [
        NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productPriceSize, ofType: .regular),
        NSAttributedStringKey.foregroundColor : AppColor.productPrice
    ]
    
    let productOldPriceAttributes: [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productOldPriceSize, ofType: .regular),
        NSAttributedStringKey.foregroundColor : AppColor.productOldPrice ,
        NSAttributedStringKey.strikethroughStyle : NSUnderlineStyle.styleSingle.rawValue
    ]

    self.productName.attributedText = NSAttributedString(string: viewModel.product.title, attributes: productNameAttributes)
    self.productPrice.attributedText = NSAttributedString(string: "17", attributes: productPriceAttributes)
    self.productOldPrice.attributedText = NSAttributedString(string: "18", attributes: productOldPriceAttributes)
    
    }
    override init() {
        super.init()
        self.backgroundColor = .white
        //  Cell configuration
       
        let size = UIScreen.main.bounds.size.width/2 - 24
            self.style.preferredSize = CGSize(width: size, height: size)
        
        
        self.productName.maximumNumberOfLines = 2

        self.automaticallyManagesSubnodes = true
        self.style.flexGrow = 1.0

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let productStack = ASStackLayoutSpec.vertical()
       
        //Image section
        let imageLayoutSpec = ASRatioLayoutSpec(ratio: 0.75, child: productImageNode)
        productStack.children?.append(imageLayoutSpec)

        let productFooterStack = ASStackLayoutSpec.vertical()
        let productNameLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2), child: productName)
        productFooterStack.children?.append(productNameLayoutSpec)
        
        let productPriceStack = ASStackLayoutSpec.horizontal()
        let productPriceLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: productPrice)
        let productOldPriceLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: productOldPrice)
        
        productPriceStack.children = [productOldPriceLayoutSpec,productPriceLayoutSpec]

        
        productFooterStack.children?.append(productPriceStack)
    
        productFooterStack.alignItems = .center
        productFooterStack.verticalAlignment = .center
        
        
        
        productStack.children?.append(productFooterStack)

        return productStack
        
        
    }
}
