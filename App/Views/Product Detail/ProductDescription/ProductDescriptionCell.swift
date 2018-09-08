//
//  ProductDescriptionCell.swift
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

class ProductDescriptionCell: UITableViewCell, NibReusable {
    private var viewModel: ProductDescriptionRowViewModel!
    
    var disposeBag = DisposeBag()

    var descriptionLabel: UILabel = UILabel(frame: CGRect.zero)

    override func awakeFromNib() {
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(row: ProductDescriptionRowViewModel){
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = row.product.description.interpretAsHTML(font: "OpenSans", size: 17)
    }
}
