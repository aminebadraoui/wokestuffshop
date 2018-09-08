//
//  HomeBrowserViewController.swift
//  App
//
//  Created by Amine on 2018-08-26.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class HomeBrowserViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    //  Properties
    var viewModel: HomeBrowserViewModel!
    
    var productGrid: UICollectionView
    
    init(vm: HomeBrowserViewModel) {
        self.viewModel = vm
        viewModel.configureFlow()
        productGrid = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewModel.cardsFlow)
        productGrid.backgroundColor = AppColor.appBackground
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setup()
        viewModel.fetchFeed()
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

        viewModel.output.datasourceOutput
            .bind(onNext: {
                self.productGrid.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
