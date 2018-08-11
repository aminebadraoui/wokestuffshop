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

struct ProductVariantsInterface {
    public var optionTitle: UILabel!
    public var optionVariant: UIButton!
}

class ProductVariantsCell: UITableViewCell, NibReusable {
    
    private var viewModel: ProductVariantsRowViewModel!
    var disposeBag = DisposeBag()
    
    @IBOutlet var containerView: UIView!
    var OptionsButtons = [ProductVariantsInterface]()
    
    override func awakeFromNib() {
        
    }
    
    func configure(row: ProductVariantsRowViewModel){
        
        
        
        self.OptionsButtons = row.product.options.map { option in
            let optionName = option.name
            let values = option.values
            
            guard optionName != "Title" else { return ProductVariantsInterface() }
            
            let optionTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            let optionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            
            optionTitle.text = optionName
            optionTitle.textAlignment = .center
            
            optionButton.setTitle(values.first, for: .normal)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.layer.borderWidth = 1.0
            optionButton.layer.borderColor = UIColor.black.cgColor
            
            let arrowImage = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            arrowImage.contentMode = .scaleAspectFit
            
            self.contentView.addSubview(optionButton)
            self.contentView.addSubview(optionTitle)
            optionButton.addSubview(arrowImage)
            
            arrowImage.snp.makeConstraints({
                $0.top.equalTo((optionButton.snp.top)).offset(2)
                $0.right.equalTo((optionButton.snp.right)).offset(2)
                $0.bottom.equalTo((optionButton.snp.bottom)).offset(-2)
                $0.height.equalTo(15)
                $0.width.equalTo(20)
            })
            optionButton.rx.tap
                .map { _ in option }
                .debug()
                .bind(to: row.inputs.optionButtonTapAction)
                .disposed(by: self.disposeBag)
            
            var variantInterface = ProductVariantsInterface()
            variantInterface.optionTitle = optionTitle
            variantInterface.optionVariant = optionButton
            
            return (variantInterface)
        }
     row.outputs.currentSelectedOptionValue.asObservable()
        .withLatestFrom(Observable.combineLatest(row.outputs.currentSelectedOptionValue.debug(), row.outputs.optionButtonTapped))
            .subscribe(onNext: { indexPath, option in
                let index = self.OptionsButtons.index(where: { (variantInterface) -> Bool in
                    variantInterface.optionTitle.text == option.name
                })
                let selectedOption = self.OptionsButtons[index!]
                selectedOption.optionVariant.setTitle(option.values[indexPath.row], for: .normal)
               
            }).disposed(by: self.disposeBag)
        
        self.configureConstraintsForVariantInterface()
        
    }
    
    private func configureConstraintsForVariantInterface(){
        
        OptionsButtons.forEach { variantInterface in
            let currentIndex = OptionsButtons.index(where: { (currentVariant) -> Bool in
                variantInterface.optionTitle == currentVariant.optionTitle
            })
            
            let optionTitle = variantInterface.optionTitle
            let optionButton = variantInterface.optionVariant
            
            if currentIndex == 0 && OptionsButtons.count != 1 {
                optionTitle?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalToSuperview().offset(8)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                })
                optionButton?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo((optionTitle?.snp.bottom)!).offset(4)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                    
                })
            }
            else if currentIndex != 0 && currentIndex != OptionsButtons.count - 1{
                optionTitle?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo(OptionsButtons[currentIndex! - 1].optionVariant.snp.bottom).offset(8)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                })
                
                optionButton?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo((optionTitle?.snp.bottom)!).offset(4)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                })
            }
                
            else if currentIndex == OptionsButtons.count - 1 && OptionsButtons.count != 1{
                
                optionTitle?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo(OptionsButtons[currentIndex! - 1].optionVariant.snp.bottom).offset(8)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                })
                
                optionButton?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo((optionTitle?.snp.bottom)!).offset(4)
                    $0.height.equalTo(20)
                    $0.bottom.equalToSuperview().offset(-8)
                    $0.width.equalTo(150)
                })
            }
                
            else if currentIndex == 0 && OptionsButtons.count == 1{
                optionTitle?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalToSuperview().offset(8)
                    $0.height.equalTo(20)
                    $0.width.equalTo(150)
                })
                
                optionButton?.snp.makeConstraints({
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo((optionTitle?.snp.bottom)!).offset(4)
                    $0.height.equalTo(20)
                    $0.bottom.equalToSuperview().offset(-8)
                    $0.width.equalTo(150)
                })
            }
        }
    }
}
