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
    var selectedOptionValue: Observable<OptionModel> { get }
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
    var option : OptionModel
    
    var datasource = Datasource()
    
    init(option: OptionModel){
        self.option = option
        
    }
    
    // Subjects
    private var _selectedOptionValueFromTableSubject = PublishSubject<IndexPath>()
    
    // Inputs
    var selectOptionValueFromTableAction: AnyObserver<IndexPath> {
        return _selectedOptionValueFromTableSubject.asObserver()
    }
    
    // Outputs
    var selectedOptionValue: Observable<OptionModel> {
        return  _selectedOptionValueFromTableSubject
            .map { indexPath in
                var option = self.option
                option.selectedValue = self.option.values[indexPath.row]
                return option
        }
    }
    
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
