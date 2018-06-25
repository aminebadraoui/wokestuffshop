//
//  ProductCellNode.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-12.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class ProductCellNode: ASCellNode {
    
    let productImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        return imageNode
    }()
    
    let productName = ASTextNode()
    let productPrice = ASTextNode()
    let productOldPrice = ASTextNode()
    
    var viewModel : ProductViewModel!
    
   func setup(vm: ProductViewModel) {
    
    self.viewModel = vm
    //  Image Configuration
  
    self.productImageNode.url = URL(string: viewModel.imageURL)
    
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

    self.productName.attributedText = NSAttributedString(string: viewModel.name, attributes: productNameAttributes)
    self.productPrice.attributedText = NSAttributedString(string: viewModel.price, attributes: productPriceAttributes)
    self.productOldPrice.attributedText = NSAttributedString(string: viewModel.oldPrice, attributes: productOldPriceAttributes)
    
    }
    override init() {
        super.init()
        self.backgroundColor = #colorLiteral(red: 0.9369235635, green: 0.9369235635, blue: 0.9369235635, alpha: 1)
        //  Cell configuration
       
            self.style.preferredSize = CGSize(width: 200, height: 300)
        self.cornerRadius = 16
        
        self.productName.maximumNumberOfLines = 2

        self.automaticallyManagesSubnodes = true
        self.style.flexGrow = 1.0

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let productStack = ASStackLayoutSpec.vertical()
       
        //Image section
        let imageLayoutSpec = ASRatioLayoutSpec(ratio: 1, child: productImageNode)
        productStack.children?.append(imageLayoutSpec)

        let productFooterStack = ASStackLayoutSpec.vertical()
        let productNameLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: productName)
        productFooterStack.children?.append(productNameLayoutSpec)
        
        let productPriceStack = ASStackLayoutSpec.horizontal()
        let productPriceLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: productPrice)
        let productOldPriceLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: productOldPrice)
        productPriceStack.children = [productOldPriceLayoutSpec,productPriceLayoutSpec]

        
        productFooterStack.children?.append(productPriceStack)
    
        productFooterStack.alignItems = .center
        productFooterStack.verticalAlignment = .center
        
        let productFooterLayoutSpec = ASRatioLayoutSpec(ratio: 0.5, child: productFooterStack)
        
        
        productStack.children?.append(productFooterLayoutSpec)

        return productStack
        
        
    }
}
