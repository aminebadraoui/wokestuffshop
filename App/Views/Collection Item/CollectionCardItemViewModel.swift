//
//  CollectionCardItemViewModel.swift
//  App
//
//  Created by Amine on 2018-07-08.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import ShopifyKit
import RxSwift
import Kingfisher

protocol CollectionCardItemViewModelInput {
    
}

protocol CollectionCardItemViewModelOutput {
    var cellTapped: Observable<Void> { get }
}

protocol CollectionCardItemViewModelType {
    var inputs: CollectionCardItemViewModelInput { get }
    var outputs: CollectionCardItemViewModelOutput { get }
}

class CollectionCardItemViewModel: CollectionCompatible, CollectionCardItemViewModelInput, CollectionCardItemViewModelOutput, CollectionCardItemViewModelType {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       collectionView.register(CollectionCardItem.self, forCellWithReuseIdentifier: "CollectionCardItem")
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCardItem", for: indexPath) as! CollectionCardItem
        
        collectionCell.configure(viewModel: self)
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         _cellTappedSubject.onNext(())
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    

    var collection: CollectionModel
    let imageUrl: URL?
    
    init(collection: CollectionModel){
        self.collection = collection
   
        if let collectionImageURL = collection.imageUrl  {
            imageUrl = collectionImageURL
        } else {
            imageUrl = collection.defaultImagURL
        }
    }
    

    // Subject
    private var _cellTappedSubject = PublishSubject<Void>()
    
    //  Outputs
    var cellTapped: Observable<Void> {
        return _cellTappedSubject.asObservable()
    }
    
    var inputs: CollectionCardItemViewModelInput { return self }
    var outputs: CollectionCardItemViewModelOutput { return self }
  
    var height: CGFloat = 250
}
