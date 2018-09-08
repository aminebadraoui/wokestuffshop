//
//  CollectionListViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import  UIKit
import RxSwift

class CollectionListViewController: UIViewController {
    
    
    let disposeBag = DisposeBag()
    
    //  Properties
    var viewModel: CollectionListVM!
    var tableView: UITableView
    
    //  initialization
    init (vm: CollectionListVM) {
        self.viewModel = vm
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        super.init(nibName: nil, bundle: nil)
        
        setupConstraints()
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
    
    func setupConstraints() {
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    func setup() {
        //Setup of the table Node

        
        tableView.delegate = viewModel.dataSource
        tableView.dataSource = viewModel.dataSource

        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
}
