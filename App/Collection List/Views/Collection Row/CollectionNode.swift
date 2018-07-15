//
//  CollectionNode.swift
//  App
//
//  Created by Amine on 2018-07-08.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

class CollectionNode: ASCellNode {
    
//  Featured Product properties are the section title,
//  the product's image, and the product
private var _collectionName: ASTextNode!
    
    private var _collectionImage: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        return imageNode
    }()
    
    let localUrl = URL(string: "https://comotion.uw.edu/wp-content/uploads/2017/06/image.jpg")
    
private let textBackgroundNode = ASDisplayNode()
    
    var collectionRowVM: CollectionRowVM!

    func setup(vm: CollectionRowVM) {
        
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 36, ofType: .bold),
            NSAttributedStringKey.foregroundColor : UIColor.white ]
        
        
        let titleText = NSAttributedString(string: vm.collection.title, attributes: titleTextAttributes)
        _collectionImage.url = vm.collection.imageUrl
        
        _collectionName.attributedText = titleText
        
}
    
    override init(){
      
        _collectionName = ASTextNode()
        super.init()
        self.view.backgroundColor = .white
         textBackgroundNode.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.automaticallyManagesSubnodes = true
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec.vertical()
        
        /*** Image Setup ***/
       
        let imageRatioSpec = ASRatioLayoutSpec(ratio: 0.4, child: _collectionImage)
        
        
        /*** Text node/ Text background overlay setup ***/
        
        // Setup the height of the text backgorund
        textBackgroundNode.style.preferredSize = CGSize(width: constrainedSize.max.width,
                                                        height:60)
        
        // Setup the text that will overlay the text background
        // Text insets
        let textOverlayInsetSpec    = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: _collectionName)
        // Relative position of the text node
        let textOverlayRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.center, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: textOverlayInsetSpec)
        //  Put the text inside the text background node
        let textOverlaySpec         = ASOverlayLayoutSpec(child: textBackgroundNode, overlay: textOverlayRelativeSpec)
        
        
        /*** Text+bg / image overlay setup ***/
        
        // Relative position of the text+bg node
        let backgroundOverlayRelativeSpec = ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: textOverlaySpec)
        // Put the text+bg node inside the image node
        let backgroundOverlaySpec         = ASOverlayLayoutSpec(child: imageRatioSpec, overlay: backgroundOverlayRelativeSpec)
        
        //  Append the final result to the stack
        mainStack.children?.append(backgroundOverlaySpec)
        
        // Final stack insets
        let mainStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: mainStack)
        return mainStackLayout
    }
    


}
