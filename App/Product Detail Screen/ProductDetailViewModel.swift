//
//  ProductDetailViewModel.swift
//  App
//
//  Created by Amine on 2018-07-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift
import RxCocoa
import MobileBuySDK

enum ProductDetailViewModelType {
    case images
    case header
    case variants
    case description
}

//  Inputs
protocol ProductDetailViewModelInputs {
    var atcAction: AnyObserver<Void>{ get }
    var newOptionValue: AnyObserver<OptionModel> { get }
}

//  Outputs
protocol ProductDetailViewModelOutputs {
    var atcTapped: Observable<ProductModel> { get }
    var selectedOption: Observable<OptionModel> { get }
    var reloadData: Observable<Void> { get }
}

protocol ProductDetailViewModelTypes {
    var inputs: ProductDetailViewModelInputs { get }
    var outputs: ProductDetailViewModelOutputs { get }
}

/*************************************************/
//  Implementation
class ProductDetailViewModel:  NSObject, ProductDetailViewModelInputs, ProductDetailViewModelOutputs, ProductDetailViewModelTypes {
    
    var disposeBag = DisposeBag()
    var title : String = ""
    var product: ProductModel!
    
    //var productDetailSections: [TableCompatible]
    var productDetailItems: [[ProductDetailItem]]!
    // var datasource = Datasource()
    
    init(product: ProductModel) {
        
        self.product = product
        self.title = product.title
        
        productDetailItems = []
        
        super.init()
        
        bindData()
        
        _newOptionValueSubject.asObservable()
            .subscribe(onNext: { newOption in
                if let index = product.options.index(where: { (option) -> Bool in
                    option.id == newOption.id
                }) {
                    self.product.options[index] = newOption
                    self._reloadData.onNext(())
                }
            })
            .disposed(by: disposeBag)
        
        
        _atcTapActionSubject.asObservable()
            .map { () in return self.product
            }
            .bind(to: _atcSubject)
            .disposed(by: disposeBag)
    }
    
    func bindData() {
        
        let productImages     = [ProductImagesRowViewModel(product: product)]
        let productHeader      = [ProductHeaderRowViewModel(product: product)]
        var productVariants    = [ProductVariantsRowViewModel]()
        let productDescription = [ProductDescriptionRowViewModel(product: product)]
        
        
        product.options.forEach { option in
            guard option.name != "Title" else { return }
            
            let row = ProductVariantsRowViewModel(product: product)
            row.outputs.selectedOption
                .map{ index in
                    return self.product.options[index]
                }
                .bind(to: _selectedOptionSubject)
                .disposed(by: disposeBag)
            
            productVariants.append(row)
        }
        
        productDetailItems =  [productImages, productHeader, productVariants, productDescription]
        
    }
    //  Subjects
    var _atcTapActionSubject = PublishSubject<Void>()
    var _atcSubject = PublishSubject<ProductModel>()
    var _selectedOptionSubject = PublishSubject<OptionModel>()
    var _newOptionValueSubject = PublishSubject<OptionModel>()
    var _reloadData = PublishSubject<Void>()
    
    // Inputs
    var atcAction: AnyObserver<Void> {
        return _atcTapActionSubject.asObserver()
    }
    
    var newOptionValue: AnyObserver<OptionModel>{
        return _newOptionValueSubject.asObserver()
    }
    
    //  Outputs
    var atcTapped: Observable<ProductModel> {
        return _atcSubject.asObservable()
    }
    
    var selectedOption: Observable<OptionModel> {
        return _selectedOptionSubject.asObservable()
    }
    
    var reloadData: Observable<Void>{
        return _reloadData.asObservable()
    }
    
    
    var inputs: ProductDetailViewModelInputs { return self }
    var outputs: ProductDetailViewModelOutputs { return self }
}

extension ProductDetailViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productDetailItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDetailItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch productDetailItems[indexPath.section][indexPath.row].type {
        case .images:
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductImagesCell.self)
            
            cell.configure(row: productDetailItems[indexPath.section][indexPath.row] as! ProductImagesRowViewModel)
            
            return cell
            
        case .header:
            
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductHeaderRowViewModel
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductHeaderCell.self)
            
            cell.configure(row: row)
            
            row.bindData()
            
            return cell
            
        case .variants:
            
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductVariantsRowViewModel
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductVariantsCell.self)
            
            cell.configure(row: row)
            
            Observable.of(self.product.options[indexPath.row]).subscribe(onNext: {
                option in
                row.inputs.option.onNext(option)
            })
                .disposed(by: disposeBag)
            
            cell.optionValue.tag = indexPath.row
            
            return cell
            
        case .description:
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductDescriptionRowViewModel
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProductDescriptionCell.self)
            cell.configure(row: row)
            return cell   
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 3 {
            return "Description"
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch productDetailItems[indexPath.section][indexPath.row].type {
        case .images:
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductImagesRowViewModel
            return row.height
            
        case .header:
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductHeaderRowViewModel
            return row.height
        case .variants:
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductVariantsRowViewModel
            return row.height
        case .description:
            let row = productDetailItems[indexPath.section][indexPath.row] as! ProductDescriptionRowViewModel
            return row.height
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0
        } else {
            return 0
        }
    }
}
