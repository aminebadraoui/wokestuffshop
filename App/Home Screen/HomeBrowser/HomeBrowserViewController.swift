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
        bindData()
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
        self.productGrid.delegate   = viewModel.datasource
    }
    
    func bindData() {
        viewModel.output.datasourceOutput
            .subscribe(onNext: {
                self.productGrid.reloadData()
                LoadingAnimation.instance.hideLoader()
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoaderSubject
            .subscribe(onNext: {
                LoadingAnimation.instance.showLoader(in: self.view)
            })
            .disposed(by: disposeBag)
        
        viewModel.hideLoaderSubject
            .subscribe(onNext: {
                LoadingAnimation.instance.hideLoader()
            })
            .disposed(by: disposeBag)
    }
}
