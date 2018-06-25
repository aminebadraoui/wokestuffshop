//
//  TableCompatible.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol TableCompatible {
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode
}
