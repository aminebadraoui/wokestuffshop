//
//  CellRepresentable.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-20.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//


import UIKit
import AsyncDisplayKit

protocol CollectionCompatible {
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode
}
