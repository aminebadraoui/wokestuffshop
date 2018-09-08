//
//  CollectionCardItem.swift
//  App
//
//  Created by Amine on 2018-08-25.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CollectionCardItem: UICollectionViewCell {
    let collectionImageView: UIImageView
    let title: UILabel
    let titleBackground: UIView
    
    override init(frame: CGRect) {
        collectionImageView = UIImageView(frame: CGRect.zero)
        collectionImageView.contentMode = .scaleAspectFill
        collectionImageView.clipsToBounds = true
        
        titleBackground = UIView(frame: CGRect.zero)
        titleBackground.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        title = UILabel(frame: CGRect.zero)
    
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CollectionCardItemViewModel ) {
        let imageURL = viewModel.imageUrl
        
        collectionImageView.kf.setImage(with: imageURL )
        
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 24, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : UIColor.white ]
        
        
        let titleText = NSAttributedString(string: viewModel.collection.title, attributes: titleTextAttributes)
        
        title.attributedText =  titleText
        self.backgroundColor = AppColor.appBackground
    }
    
    func setupConstraints() {
        self.addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalToSuperview().offset(-16)
        })
        
        self.collectionImageView.addSubview(titleBackground)
        titleBackground.snp.makeConstraints({
            $0.height.equalTo(40)
            $0.right.equalTo(0)
            $0.left.equalTo(0)
            $0.centerY.equalToSuperview()
        })
        
        self.titleBackground.addSubview(title)
        title.snp.makeConstraints({
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
    }
}
