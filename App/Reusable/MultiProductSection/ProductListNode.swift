//
//  ProductListNode.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-17.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit

class ProductListNode: ASCellNode {

    //  Properties:
    //  A list has a title and a collection
    private var _collectionTitleNode: ASTextNode!
    private var  _collectionNode: ASCollectionNode!

    //  The datasource for the collection
    var sectionDatasource = Datasource()

    func setup(vm: ProductListSectionViewModel) {
 
        /*** Title Setup ****/
        
        //  Title attributes
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 36, ofType: .bold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor ]
        
        //  Title text
        _collectionTitleNode.attributedText =  NSAttributedString(string: vm.sectionTitle, attributes: titleTextAttributes)
        
        
        /**** Collection setup ****/
        
        //  Collection custom layout
        _collectionNode.style.preferredSize.height = 300
        _collectionNode.style.flexGrow = 1.0
        _collectionNode.view.showsHorizontalScrollIndicator = false
        
        //  Create a productViewModel for every productModel from the view model
        //  and append it to the productListDataSource
        var productList = [ProductListItemViewModel]()
        for product in vm.productListDatasource {
            let productViewModel = ProductListItemViewModel(productModel: product)
            productList.append(productViewModel)
        }
        
        //  Assigning the productListDatasource to the collection dataSource
        sectionDatasource.ASCollectionData =  productList
        
        _collectionNode.delegate = sectionDatasource
        _collectionNode.dataSource = sectionDatasource
        
        /*** General settings ***/
        
        self.style.flexGrow = 1.0
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
    }
    
    override init() {
        
        super.init()
        
        //  Title init
        _collectionTitleNode = ASTextNode()
        
        //  Collection init
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
     
        
        _collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: layout)
 
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        //  This node is a vertical stack with a title on top and the collection below it
        let mainStack = ASStackLayoutSpec.vertical()

        //  Setting up the insets of the title and then appending it to the stack
        let collectionTitleSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 16), child: _collectionTitleNode)
        mainStack.children?.append(collectionTitleSpec)
        
        //  Setting up the insets of the collection and then appending it to the stack
        let collectionSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: _collectionNode)
        mainStack.children?.append(collectionSpec)
        
        //  Setting up the insets of the stack before returning its layout 
        let mainStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 32, right: 0), child: mainStack)
        return mainStackLayout
    }
}



