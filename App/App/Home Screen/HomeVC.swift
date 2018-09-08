//
//  HomeViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//


import ShopifyKit
import MobileBuySDK
import RxSwift
import SnapKit

class HomeViewController: UIViewController {
    let client = Client.shared
    
    let disposeBag = DisposeBag()
    
    //  Properties
    var tableview: UITableView
    var viewModel: HomeViewModel!
    
 
    init (vm: HomeViewModel) {
     
        self.viewModel = vm
       
        tableview = UITableView(frame: CGRect.zero, style: .plain)
       
//        viewModel.outputs.datasourceOutput
//            .bind(onNext: { self.homeTableNode.reloadData()
//            }).disposed(by: disposeBag)
//
           super.init(nibName: nil, bundle: nil)
         self.view.addSubview(tableview)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //Setup of the table Node
   
//        homeTableNode.view.allowsSelection = false
//        homeTableNode.view.separatorStyle = .singleLine
//
//        homeTableNode.delegate = viewModel.dataSource
//        homeTableNode.dataSource = viewModel.dataSource
        
        tableview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableview.separatorStyle = .none
        tableview.delegate = viewModel.dataSource
        tableview.delegate = viewModel.dataSource
        
        //  Setup of the navigation item
        self.navigationItem.titleView =  UIImageView(image: #imageLiteral(resourceName: "logo_wokestuff"))
        
        //  Setup of the background view
        self.view.backgroundColor = .white
    }
    
    
}




