//
//  ProductDetailViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {
    var viewModel: ProductDetailViewModel!
    
    var disposeBag = DisposeBag()
    
    public static func instantiate(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        let vc = UIStoryboard(name: "ProductDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        
        vc.viewModel = viewModel
        return vc
    }
  
    override func viewDidLoad() {
   
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(cellType: ProductImagesCell.self)
        tableView.register(cellType: ProductHeaderCell.self)
        tableView.register(cellType: ProductVariantsCell.self)
        tableView.register(cellType: ProductDescriptionCell.self)
        
        self.title = viewModel.title
        
        productBtn.rx.tap
            .bind(to: viewModel.inputs.atcAction)
            .disposed(by: disposeBag)
        
        viewModel.outputs.reloadData
            .subscribe(onNext: {
                self.tableView.reloadData()
            })
        .disposed(by: disposeBag)
    }

    
    @IBOutlet weak var productBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var showCart = PublishSubject<Bool>()
    
}
