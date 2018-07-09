//
//  FeaturedProductNode.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-24.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//


import AsyncDisplayKit

class FeaturedProductNode: ASDisplayNode {
    
    private let _featuredImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        return imageNode
    }()
    
    private let textBackgroundNode = ASDisplayNode()
    
   // private var _productImageUrl: String = ""
    private var _productTitle = ASTextNode()
    private var _productPrice = ASTextNode()
    private var _productOldPrice = ASTextNode()
    
    private var viewModel: FeaturedProductViewModel!
    
    func setup(vm: FeaturedProductViewModel) {
        self.viewModel = vm
       // _productImageUrl = vm.product.imageURL
       
      //  _featuredImageNode.url = URL(string: _productImageUrl)
        
        
        //  Title setup
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 24, ofType: .bold),
            NSAttributedStringKey.foregroundColor : UIColor.white ]
        
        
        let titleText = NSAttributedString(string: vm.product.title, attributes: titleTextAttributes)
        
        _productTitle.attributedText = titleText
        
        
        textBackgroundNode.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        // General settings
        self.style.flexGrow = 1.0
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
       let mainStack = ASStackLayoutSpec.vertical()
        
        /*** Image Setup ***/
        let imageRatioSpec = ASRatioLayoutSpec(ratio: 1, child: _featuredImageNode)
     
        
        /*** Text node/ Text background overlay setup ***/
        
        // Setup the height of the text backgorund
        textBackgroundNode.style.preferredSize = CGSize(width: constrainedSize.max.width,
                                              height:90)
        
        // Setup the text that will overlay the text background
        // Text insets
       let textOverlayInsetSpec    = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: _productTitle)
        // Relative position of the text node
       let textOverlayRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: textOverlayInsetSpec)
        //  Put the text inside the text background node
       let textOverlaySpec         = ASOverlayLayoutSpec(child: textBackgroundNode, overlay: textOverlayRelativeSpec)
        
        
        /*** Text+bg / image overlay setup ***/

        // Relative position of the text+bg node
        let backgroundOverlayRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.end, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: textOverlaySpec)
        // Put the text+bg node inside the image node
        let backgroundOverlaySpec         = ASOverlayLayoutSpec(child: imageRatioSpec, overlay: backgroundOverlayRelativeSpec)
        
        //  Append the final result to the stack
        mainStack.children?.append(backgroundOverlaySpec)
        
        // Final stack insets
        let mainStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0), child: mainStack)
        return mainStackLayout
    }
    
}
