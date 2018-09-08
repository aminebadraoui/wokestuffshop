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

protocol CollectionRowInputs {
    
}

protocol CollectionRowOutputs {
    var cellTapped: Observable<Void> { get }
}

protocol CollectionRowTypes {
    var inputs: CollectionRowInputs { get }
    var outputs: CollectionRowOutputs { get }
}

class CollectionCardItemViewModel: CollectionCompatible, CollectionRowInputs, CollectionRowOutputs, CollectionRowTypes {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
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
    
    var inputs: CollectionRowInputs { return self }
    var outputs: CollectionRowOutputs { return self }
  
    var height: CGFloat = 250
}
