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
    let titleBackground: UIView
    let titleStackView: UIStackView
    let title: UILabel
    let shopCollectionButton: UIButton
    let gradient = CAGradientLayer()
    
    
    override init(frame: CGRect) {
        collectionImageView = UIImageView(frame: CGRect.zero)
        collectionImageView.contentMode = .scaleAspectFill
        collectionImageView.clipsToBounds = true
        
        titleBackground = UIView(frame: CGRect.zero)
       
        title = UILabel(frame: CGRect.zero)
        shopCollectionButton = UIButton(frame: CGRect.zero)
        
        titleStackView = UIStackView(frame: CGRect.zero)
        
        super.init(frame: frame)
        
        setupViews()
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
    
    func setupViews() {
        let shopButtonTitleAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 16, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        let shopButtonTitle = NSAttributedString(string: "Shop Collection", attributes: shopButtonTitleAttributes)
        
        shopCollectionButton.setAttributedTitle(shopButtonTitle, for: .normal)
        shopCollectionButton.backgroundColor = .white
        shopCollectionButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        
        shopCollectionButton.setTitleColor(.black, for: .normal)
        
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.spacing = 8.0
        
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(shopCollectionButton)
        
        
        gradient.frame = titleBackground.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.locations = [0.3]
        
        titleBackground.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = titleBackground.bounds
        
    }

    func setupConstraints() {
        self.addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
        })
        
        self.collectionImageView.addSubview(titleBackground)
        titleBackground.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        self.titleBackground.addSubview(titleStackView)
        titleStackView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        })
    }
}
