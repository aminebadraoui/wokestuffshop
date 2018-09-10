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
    private var backgroundImageView: UIImageView
    private var gradient = CAGradientLayer()
    
    private var collectionImageView: UIImageView
    
    private var titleBackground: UIView
    private var title: UILabel
    private var shopCollectionButton: UIButton
    private var titleStackView: UIStackView
    
    private var collectionViewTitleContainer: UIView
    private var collectionViewTitle: UILabel
    private var viewAllTitle: UILabel
    private var collectionView: UICollectionView
    
    override init(frame: CGRect) {
        backgroundImageView = UIImageView(frame: CGRect.zero)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        collectionImageView = UIImageView(frame: CGRect.zero)
        collectionImageView.contentMode = .scaleAspectFill
        collectionImageView.clipsToBounds = true
        
        titleBackground = UIView(frame: CGRect.zero)
       
        title = UILabel(frame: CGRect.zero)
        shopCollectionButton = UIButton(frame: CGRect.zero)
        
        titleStackView = UIStackView(frame: CGRect.zero)
        
        collectionViewTitleContainer = UIView(frame: CGRect.zero)
        collectionViewTitle = UILabel(frame: CGRect.zero)
        viewAllTitle = UILabel(frame: CGRect.zero)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 150, height: 200)
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CollectionCardItemViewModel ) {
        let imageURL = viewModel.imageUrl
        viewModel.datasourceOutput
            .subscribe(onNext: {
                self.collectionView.reloadData()
            })
        .disposed(by: disposeBag)
        
        backgroundImageView.kf.setImage(with: imageURL)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.addSubview(blurEffectView)
        
        collectionImageView.kf.setImage(with: imageURL )
        
        let titleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 24, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : UIColor.white ]
        
        let titleText = NSAttributedString(string: viewModel.collection.title, attributes: titleTextAttributes)
        title.attributedText =  titleText
        
        let collectionTitleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 12, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        let collectionTitleText = NSAttributedString(string: viewModel.collection.title, attributes: collectionTitleTextAttributes)
        collectionViewTitle.attributedText = collectionTitleText
        
        let viewAllTitleTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 12, ofType: .semibold),
            NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        let viewAllTitleText = NSAttributedString(string: "View All", attributes: viewAllTitleTextAttributes)
        viewAllTitle.attributedText = viewAllTitleText
        
        self.backgroundColor = AppColor.appBackground
        
        collectionView.backgroundColor = AppColor.appBackground
        
        collectionView.delegate = viewModel.datasource
        collectionView.dataSource = viewModel.datasource
    }
    
    func setupViews() {
        let shopButtonTitleAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : AppFont.customFont(ofSize: 12, ofType: .semibold),
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
        gradient.colors = [UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.clear.withAlphaComponent(0).cgColor]
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
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalToSuperview().offset(-300)
        })
        
        self.addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalToSuperview().offset(-332)
            $0.right.equalToSuperview().offset(-16)
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
        
        self.addSubview(collectionViewTitleContainer)
        collectionViewTitleContainer.snp.makeConstraints({
            $0.top.equalTo(backgroundImageView.snp.bottom)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(50)
        })
        
        collectionViewTitleContainer.addSubview(collectionViewTitle)
        collectionViewTitle.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        })
        
        collectionViewTitleContainer.addSubview(viewAllTitle)
        viewAllTitle.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        })
        
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.top.equalTo(collectionViewTitleContainer.snp.bottom)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
}
