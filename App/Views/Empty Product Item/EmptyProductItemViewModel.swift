//
//  EmptyProductItemViewModel.swift
//  App
//
//  Created by Amine Badraoui on 2018-09-09.
//  Copyright © 2018 Amine Badraoui. All rights reserved.
//

import ShopifyKit
import RxSwift

class EmptyProductItemViewModel: CollectionCompatible  {
    let productTitle: String
    
    init () {
        self.productTitle = " No products available at this time"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(EmptyProductItemCell.self, forCellWithReuseIdentifier: "EmptyProductItemCell")
        let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyProductItemCell", for: indexPath) as! EmptyProductItemCell
        productCell.configure(viewModel: self)
        
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
