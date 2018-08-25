//
//  ASTableCompatible.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-21.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import AsyncDisplayKit

protocol ASTableCompatible {
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath)
    
    func tableNode(_ tableNode: ASTableNode, didHighlightRowAt indexPath: IndexPath) 
}
