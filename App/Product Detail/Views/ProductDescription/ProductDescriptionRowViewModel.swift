//
//  ProductDescriptionRowViewModel.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
import RxSwift
import RxCocoa

protocol ProductDescriptionRowViewModelInputs {
    
}

protocol ProductDescriptionRowViewModelOutputs {
    var productDescription: Observable<String> { get }
}

protocol ProductDescriptionRowViewModelTypes {
    var inputs: ProductDescriptionRowViewModelInputs { get }
    var outputs: ProductDescriptionRowViewModelOutputs { get }
}

class ProductDescriptionRowViewModel: TableCompatible, ProductDescriptionRowViewModelInputs, ProductDescriptionRowViewModelOutputs, ProductDescriptionRowViewModelTypes   {
    
    /******************************/
    //  MARK: Initialization
    init(product: ProductModel){
        self.product = product
    }
    var refreshRow = PublishSubject<IndexPath>()
    var disposeBag = DisposeBag()
    
    /******************************/
    //  MARK: TableView delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var rowDisposeBag = DisposeBag()
        tableView.register(cellType: ProductDescriptionCell.self)
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductDescriptionCell.self)
        
//       cell.heightObservable.asObservable()
//        .map {height in
//            self.height = height
//            return indexPath
//        }.bind(to: refreshRow)
//        .disposed(by: disposeBag)
        
        cell.configure(row: self)
        
       // _productDescriptionSubject.onNext(product.description.htmlToString)

        return cell
    }
    
    /******************************/
    //  MARK: Variables
    
    var height: CGFloat = UITableViewAutomaticDimension
     var product: ProductModel
    
    //  Subjects
    private var _productDescriptionSubject = PublishSubject<String>()
    
    //  Inputs
    
    //  Outputs
    var productDescription: Observable<String> {
        return _productDescriptionSubject.asObservable()
    }
    
    //  Type
    var inputs: ProductDescriptionRowViewModelInputs { return self }
    var outputs: ProductDescriptionRowViewModelOutputs { return self }
    
}
