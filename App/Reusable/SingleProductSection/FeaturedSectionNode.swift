//
//  FeaturedSection.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-18.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

class FeaturedSectionNode: ASCellNode {
    
    //  Featured Product properties are the section title,
    //  the product's image, and the product
    private var _featuredTitleNode: ASTextNode!
    private var _featuredProductNode: FeaturedProductNode
   
    
    var featuredProductVM: FeaturedSectionViewModel!

    func setup(vm: FeaturedSectionViewModel) {
        
        
        //  Title setup
        
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 36, ofType: .bold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor ]
        
        
        let titleText = NSAttributedString(string: vm.sectionTitle, attributes: titleTextAttributes)
        
        _featuredTitleNode.attributedText = titleText
        
        
        //  Featured Product Setup
        let featuredProductVM = FeaturedProductViewModel(product: vm.productDatasource)
        _featuredProductNode.setup(vm: featuredProductVM)
        
        // General settings
        self.style.flexGrow = 1.0
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
       
    }
    
    override init(){
        _featuredTitleNode = ASTextNode()
        _featuredProductNode = FeaturedProductNode()
        
        super.init()
    }

    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        let mainStack = ASStackLayoutSpec.vertical()
        
        let titleSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 16), child: _featuredTitleNode)
        mainStack.children?.append(titleSpec)
        
        let featuredProductSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8), child: _featuredProductNode)
        mainStack.children?.append(featuredProductSpec)
       
        
        let mainStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), child: mainStack)
        return mainStackLayout
    }
}
