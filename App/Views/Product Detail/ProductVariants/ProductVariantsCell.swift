//
//  ProductVariantsCell.swift
//  App
//
//  Created by Amine on 2018-07-27.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import SnapKit
import ShopifyKit


class ProductVariantsCell: UITableViewCell, NibReusable {
    
    private var viewModel: ProductVariantsRowViewModel!
    override func prepareForReuse() {
        super.prepareForReuse()
         disposeBag = DisposeBag()
    }
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var optionValue: UIButton!
    
    func configure(row: ProductVariantsRowViewModel){
        self.viewModel = row
        
        row.outputs.optionTitle
            .asDriver(onErrorJustReturn: "")
            .drive(self.optionTitle.rx.text)
            .disposed(by: disposeBag)

        row.outputs.optionValue
            .asDriver(onErrorJustReturn: "")
            .drive(self.optionValue.rx.title(for: .normal))
            .disposed(by: disposeBag)

        optionValue.rx.tap.debug()
            .map {
                return self.optionValue.tag
            }
            .bind(to: row.inputs.selectOptionAction)
            .disposed(by: disposeBag)
    }
}

