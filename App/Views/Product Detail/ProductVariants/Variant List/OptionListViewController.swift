//
//  OptionListViewController.swift
//  App
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MobileBuySDK

class OptionListViewController: UIViewController{

    @IBOutlet weak var tableview: UITableView!
 
    var viewModel: OptionListViewModel!
    var disposeBag = DisposeBag()
    
    public static func make(viewModel: OptionListViewModel) -> OptionListViewController {
        let vc = UIStoryboard(name: "OptionListViewController", bundle: nil).instantiateViewController(withIdentifier: "OptionListViewController") as! OptionListViewController
        
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
                
                let transition:CATransition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionReveal
                transition.subtype = kCATransitionFromBottom
                self?.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
}
    
}
