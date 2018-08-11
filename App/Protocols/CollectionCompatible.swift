//
//  CollectionCompatible.swift
//  App
//
//  Created by Amine on 2018-07-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

protocol CollectionCompatible {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell 
}
