//
//  CartCell.swift
//  App
//
//  Created by Amine on 2018-08-07.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Reusable
import ShopifyKit
import RxSwift
import AlamofireImage
import Alamofire

class CartCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var titleLabel:    UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var priceLabel:    UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var stepper:       UIStepper! {
        didSet {
            stepper.value = 2.0
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
    }
    
    override func awakeFromNib() {
        
    }
   
    func configure(row: CartRowViewModel) {
        
        row.outputs.productTitleView
            .asDriver(onErrorJustReturn: "")
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        row.outputs.priceView
            .asDriver(onErrorJustReturn: "")
            .drive(priceLabel.rx.text)
            .disposed(by: disposeBag)
       
        row.outputs.variantTitleView
            .asDriver(onErrorJustReturn: "")
            .drive(subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        row.outputs.quantityView
            .asDriver(onErrorJustReturn: "")
            .drive(quantityLabel.rx.text)
            .disposed(by: disposeBag)
        
        row.outputs.quantityView
            .map { Double($0)! + 1}
            .asDriver(onErrorJustReturn: 0)
            .drive(stepper.rx.value)
            .disposed(by: disposeBag)
        
        row.outputs.imageUrl
            .subscribe(onNext: { url in
                Alamofire.request((url?.absoluteString)!).responseImage { response in
                    if let image = response.result.value {
                        self.thumbnailView?.image = image }
                    }
            })
                    .disposed(by: disposeBag)
        
        stepper.rx.value
            .map { Int($0) - 1 }
            .bind(to: row.inputs.stepperTapAction)
            .disposed(by: disposeBag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
