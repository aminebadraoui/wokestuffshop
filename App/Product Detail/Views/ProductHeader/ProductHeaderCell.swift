//
//  ProductHeaderCell.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class ProductHeaderCell: UITableViewCell, NibReusable {
    private var viewModel: ProductHeaderRowViewModel!
    var disposeBag = DisposeBag()
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var compareAtPrice: UILabel!
    
    func configure(row: ProductHeaderRowViewModel){
        row.outputs.nameView
            .asDriver(onErrorJustReturn: NSAttributedString(string: ""))
            .drive(productName.rx.attributedText)
            .disposed(by: disposeBag)
        
        row.outputs.priceView
            .asDriver(onErrorJustReturn: NSAttributedString(string: ""))
            .drive(price.rx.attributedText)
            .disposed(by: disposeBag)
        
        row.outputs.compareAtPriceView
            .asDriver(onErrorJustReturn: NSAttributedString(string: ""))
            .drive(compareAtPrice.rx.attributedText)
            .disposed(by: disposeBag)
        

       
    }
    
}
