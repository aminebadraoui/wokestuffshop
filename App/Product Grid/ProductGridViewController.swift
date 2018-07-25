//
//  ProductListVC.swift
//  App
//
//  Created by Amine on 2018-07-14.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import  UIKit
import RxSwift
import AsyncDisplayKit

class ProductGridViewController: ASViewController<ASCollectionNode>  {
    
    
    let disposeBag = DisposeBag()
    
    //  Properties
    var productList: ASCollectionNode!
    var viewModel: ProductGridViewModel!
    
    //  initialization
    init (vm: ProductGridViewModel) {
        
        self.viewModel = vm
        
        let productListFlow = UICollectionViewFlowLayout()
        productListFlow.scrollDirection = .vertical
        productListFlow.minimumInteritemSpacing = 1
        productListFlow.minimumLineSpacing = 8
        productListFlow.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        productList  = ASCollectionNode(frame: CGRect.zero, collectionViewLayout: productListFlow)
        productList.backgroundColor = .red
        productList.automaticallyManagesSubnodes = true
        productList.style.flexGrow = 1
        
        super.init(node: productList)
        
        self.view.backgroundColor = #colorLiteral(red: 0.9163427982, green: 0.9163427982, blue: 0.9163427982, alpha: 1)
        
        setup()
        
        viewModel.fetchProducts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productList.view.isScrollEnabled = true
    }
    
    
    func setup() {
        self.productList.dataSource = viewModel.datasource
        self.productList.delegate = viewModel.datasource
        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        viewModel.outputs.datasourceOutput
            .bind(onNext: { self.productList.reloadData() })
            .disposed(by: disposeBag)
    }
}
