//
//  OptionListViewController.swift
//  App
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Rswift
import Reusable
import RxSwift
import RxCocoa
import MobileBuySDK

class OptionListViewController: UIViewController, StoryboardSceneBased {
    

    @IBOutlet weak var tableview: UITableView!
 
    static var sceneStoryboard: UIStoryboard = R.storyboard.optionListViewController()
    
    var viewModel: OptionListViewModel!
    var disposeBag = DisposeBag()
    
    public static func make(viewModel: OptionListViewModel) -> OptionListViewController {
        let vc = self.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = viewModel
        tableview.delegate = viewModel
        
        tableview.rx.itemSelected.debug()
            .subscribe(onNext: {[weak self] indexPath in
                self?.viewModel.inputs.selectOptionValueFromTableAction.onNext(indexPath)
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
}
    
}
