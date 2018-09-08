//
//  ProductListViewController.swift
//  App
//
//  Created by Amine on 2018-07-14.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import  UIKit
import RxSwift

class ProductGridViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //  Properties
    var viewModel: ProductGridViewModel!
    
    var productGrid: UICollectionView
    
    
    //  initialization
    init (vm: ProductGridViewModel) {
        self.viewModel = vm
        
        let productListFlow = UICollectionViewFlowLayout()
        productListFlow.scrollDirection         = .vertical
        productListFlow.minimumInteritemSpacing = 1
        productListFlow.minimumLineSpacing      = 8
        productListFlow.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        productListFlow.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 16, height: 250)
        
        productGrid = UICollectionView(frame: CGRect.zero, collectionViewLayout: productListFlow)
        productGrid.backgroundColor = AppColor.appBackground
       
         super.init(nibName: nil, bundle: nil)
        
        setupConstraints()
        setup()
        
        viewModel.fetchProducts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    func setupConstraints() {
        self.view.addSubview(productGrid)
        productGrid.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    func setup() {
        self.productGrid.dataSource = viewModel.datasource
        self.productGrid.delegate = viewModel.datasource
        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.tintColor = .white 
  
        
        viewModel.outputs.datasourceOutput
            .bind(onNext: { self.productGrid.reloadData() })
            .disposed(by: disposeBag)
    }
}
