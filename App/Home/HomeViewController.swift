//
//  HomeViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import Rswift
import AsyncDisplayKit
import ShopifyKit
import MobileBuySDK
import RxSwift



class HomeViewController: ASViewController<ASTableNode>  {
    
    let client = Client.shared
    let disposeBag = DisposeBag()
    
    //  Properties
    var homeTableNode: ASTableNode!
    var viewModel: HomeViewModel!
    
    //  initialization
    init (vm: HomeViewModel) {
        
        self.viewModel = vm
        homeTableNode  = ASTableNode()
       
        super.init(node: homeTableNode)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        //  Request tests
        //  To be removed
        let bikiniObservable = client.fetchCollection(handle: "home").asObservable().share(replay: 1)
      
        bikiniObservable.observeOn(MainScheduler.instance)
            .flatMap  {  self.client.fetchProducts(in: $0)  }
            .subscribe(onNext: { productList in
                productList.forEach {print($0.title) }
            }).disposed(by: disposeBag)

        //Setup of the table Node
        homeTableNode.view.allowsSelection = false
        homeTableNode.view.separatorStyle = .none
        
        homeTableNode.delegate = viewModel.dataSource
        homeTableNode.dataSource = viewModel.dataSource
        
        //  Setup of the navigation item
        self.navigationItem.titleView =  UIImageView(image: #imageLiteral(resourceName: "logo_wokestuff"))
        
        //  Setup of the background view
        self.view.backgroundColor = .white
    }
    
    
}




