//
//  HomeVC.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import MobileBuySDK
import RxSwift

class HomeVC: ASViewController<ASTableNode>  {
    let client = Client.shared
    
    let disposeBag = DisposeBag()
    
    //  Properties
    var homeTableNode: ASTableNode!
    var viewModel: HomeVM!
    
    //  initialization
    init (vm: HomeVM) {
        self.viewModel = vm
        
        homeTableNode = ASTableNode()
       
        super.init(node: homeTableNode)
        
        viewModel.outputs.datasourceOutput
            .bind(onNext: { self.homeTableNode.reloadData()
            }).disposed(by: disposeBag)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //Setup of the table Node
   
        homeTableNode.view.allowsSelection = false
        homeTableNode.view.separatorStyle = .singleLine
        
        homeTableNode.delegate = viewModel.dataSource
        homeTableNode.dataSource = viewModel.dataSource
        
        //  Setup of the navigation item
        self.navigationItem.titleView =  UIImageView(image: #imageLiteral(resourceName: "logo_wokestuff"))
        
        //  Setup of the background view
        self.view.backgroundColor = .white
    }
    
    
}




