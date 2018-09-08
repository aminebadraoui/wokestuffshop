//
//  OptionListViewModel.swift
//  App
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import ShopifyKit
import RxSwift
import RxCocoa
import MobileBuySDK

protocol VariantListViewModelInputs {
    var selectOptionFromTableAction: AnyObserver<IndexPath> { get }
}

protocol VariantListViewModelOutputs {
    var selectedOptionValue: Observable<String> { get }
}

protocol VariantListViewModelTypes {
    var inputs: VariantListViewModelInputs { get }
    var outputs: VariantListViewModelOutputs { get }
}

class OptionListViewModel: NSObject,
    VariantListViewModelInputs,
    VariantListViewModelOutputs,
    VariantListViewModelTypes
{
    
    
    var disposeBag = DisposeBag()
    var option : Storefront.ProductOption
    
    var datasource = Datasource()
    
    init(option: Storefront.ProductOption){
        self.option = option
        
         selectedOptionValue =
            _selectedOptionFromTableSubject.asObservable()
            .map { indexPath in
                option.values[indexPath.row]
        }
    }
    
    // Subjects
    private var _selectedOptionFromTableSubject = PublishSubject<IndexPath>()
    
    // Inputs
    var selectOptionFromTableAction: AnyObserver<IndexPath> {
        return _selectedOptionFromTableSubject.asObserver()
    }
    
    // Outputs
    var selectedOptionValue: Observable<String>
    
    var inputs: VariantListViewModelInputs { return self }
    var outputs: VariantListViewModelOutputs { return self }
}


extension OptionListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as? OptionValueCell
        
        cell?.optionName.text = option.values[indexPath.row]
        return cell!
        
    }
}
