//
//  ProductListNode.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-17.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import ShopifyKit

class ProductListNode: ASCellNode {
    
    //  Properties:
    //  A list has a title and a collection
    private var _sectionTitle: ASTextNode!
    private var  _collectionNode: ASCollectionNode!
    private var  _viewAllButton: ASButtonNode!
    
    //  rx
    var disposeBag = DisposeBag()
    var _selectedProductSubject = PublishSubject<ProductModel>()
    var _viewAllTapSubject = PublishSubject<Void>()
    
    var viewModel: ProductListSectionViewModel!
    
    //  The datasource for the collection
    var sectionDatasource = Datasource()
    
    func configure(viewModel: ProductListSectionViewModel) {
        self.viewModel = viewModel
        
        setupTitle()
        setupViewAllButton()
        feedDatasource()
        setupView()
  
    }
    
    override init() {
        super.init()
        
        setupCollectionNode()
    }
    
    fileprivate func setupViewAllButton() {
        _viewAllButton = ASButtonNode()
        
        let viewAllTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 16, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor ]
        
        let viewAllAttributedTitle = NSAttributedString(string: "View all",
                                                        attributes: viewAllTextAttributes)
        
        _viewAllButton.setAttributedTitle(viewAllAttributedTitle, for: .normal)
        
        _viewAllButton.addTarget(nil, action: #selector(viewAllTapAction), forControlEvents: .touchUpInside)
    }
    
    fileprivate func setupTitle() {
        //  Title init
        _sectionTitle = ASTextNode()
        
        //  Title attributes
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 24, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : AppColor.defaultColor ]
        
        //  Title text
        _sectionTitle.attributedText =  NSAttributedString(string: viewModel.sectionTitle, attributes: titleTextAttributes)
    }
    
    fileprivate func setupView() {
        self.style.flexGrow = 1.0
        self.backgroundColor = .white
        self.automaticallyManagesSubnodes = true
    }
    
    fileprivate func setupCollectionNode() {
        //  Collection custom layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        _collectionNode = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: layout)
        
        _collectionNode.style.preferredSize.height = 200
        _collectionNode.style.flexGrow = 1.0
        _collectionNode.view.showsHorizontalScrollIndicator = false
        _collectionNode.backgroundColor = AppColor.appBackground
        
        _collectionNode.delegate = sectionDatasource
        _collectionNode.dataSource = sectionDatasource
    }
    
    fileprivate func feedDatasource() {
        //  Create a productViewModel for every productModel from the view model
        //  and append it to the productListDataSource
        var productList = [ProductListItemViewModel]()
        
        for product in viewModel.productListDatasource {
            let collectionItem = ProductListItemViewModel(productModel: product)
            
            collectionItem.outputs.cellTapped
                .map{ _ in product }
                .bind(to: self._selectedProductSubject)
                .disposed(by: disposeBag)
            
            productList.append(collectionItem)
        }
        sectionDatasource.ASCollectionData = productList
    }
    
    @objc fileprivate func viewAllTapAction(){
        _viewAllTapSubject.onNext(())
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        //  This node is a vertical stack with a title on top and the collection below it
        let mainStack = ASStackLayoutSpec.vertical()
        
        let headerStack = ASStackLayoutSpec.horizontal()
    
        //  Setting up the insets of the title and then appending it to the stack
        let collectionTitleSpec = ASRelativeLayoutSpec(horizontalPosition: .start, verticalPosition: .center, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: _sectionTitle)

        let buttonSpec = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .center, sizingOption: .minimumSize, child: _viewAllButton)
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0

        let headerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: headerStack)
      
        headerStack.children = [collectionTitleSpec, spacer, buttonSpec]
     
        //  Setting up the insets of the collection and then appending it to the stack
        let collectionSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), child: _collectionNode)
       
        mainStack.children = [headerSpec, collectionSpec]
        
        //  Setting up the insets of the stack before returning its layout 
        let mainStackLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0), child: mainStack)
        
        return mainStackLayout
    }
}



