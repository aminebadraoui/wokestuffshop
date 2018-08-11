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

protocol OptionListViewModelInputs {
    var selectOptionValueFromTableAction: AnyObserver<IndexPath> { get }
}

protocol OptionListViewModelOutputs {
    var selectedOptionValue: Observable<IndexPath> { get }
}

protocol OptionListViewModelTypes {
    var inputs: OptionListViewModelInputs { get }
    var outputs: OptionListViewModelOutputs { get }
}

class OptionListViewModel: NSObject,
    OptionListViewModelInputs,
    OptionListViewModelOutputs,
    OptionListViewModelTypes
{
    
    
    var disposeBag = DisposeBag()
    var option : Storefront.ProductOption
    
    var datasource = Datasource()
    
    init(option: Storefront.ProductOption){
        self.option = option
        
         selectedOptionValue =
            _selectedOptionValueFromTableSubject.asObservable()
    }
    
    // Subjects
    private var _selectedOptionValueFromTableSubject = PublishSubject<IndexPath>()
    
    // Inputs
    var selectOptionValueFromTableAction: AnyObserver<IndexPath> {
        return _selectedOptionValueFromTableSubject.asObserver()
    }
    
    // Outputs
    var selectedOptionValue: Observable<IndexPath>
    
    var inputs: OptionListViewModelInputs { return self }
    var outputs: OptionListViewModelOutputs { return self }
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
