//
//  CollectionRowVM.swift
//  App
//
//  Created by Amine on 2018-07-08.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import AsyncDisplayKit
import ShopifyKit
import RxSwift

protocol CollectionRowInputs {
    
}

protocol CollectionRowOutputs {
    var cellTapped: Observable<Void> { get }
}

protocol CollectionRowTypes {
    var inputs: CollectionRowInputs { get }
    var outputs: CollectionRowOutputs { get }
}

class CollectionRowVM: ASTableCompatible, CollectionRowInputs, CollectionRowOutputs, CollectionRowTypes {
    
    var collection: CollectionModel
    
    init(collection: CollectionModel){
        self.collection = collection
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let collectionNode = CollectionNode()
        collectionNode.setup(vm: self)
        return collectionNode
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        _cellTappedSubject.onNext(())
    }
    
    // Subject
    private var _cellTappedSubject = PublishSubject<Void>()
    
    //  Outputs
    var cellTapped: Observable<Void> {
        return _cellTappedSubject.asObservable()
    }
    
    var inputs: CollectionRowInputs { return self }
    var outputs: CollectionRowOutputs { return self }
    
    
    
    
}
