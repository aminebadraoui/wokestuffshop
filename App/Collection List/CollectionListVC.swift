//
//  CollectionListVC.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import  UIKit
import RxSwift
import AsyncDisplayKit

class CollectionListVC: ASViewController<ASTableNode>  {
    

    let disposeBag = DisposeBag()
    
    //  Properties
    var collectionListTable: ASTableNode!
    var viewModel: CollectionListVM!
    
    //  initialization
    init (vm: CollectionListVM) {
        
        self.viewModel = vm
        collectionListTable  = ASTableNode()
        
        super.init(node: collectionListTable)
        
        setup()
        viewModel.fetchCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
       
    }
    

    func setup() {
        //Setup of the table Node
        collectionListTable.view.allowsSelection = false
        collectionListTable.view.separatorStyle = .none
        
        collectionListTable.delegate = viewModel.dataSource
        collectionListTable.dataSource = viewModel.dataSource
        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
}
