//
//  TableCompatible.swift
//  App
//
//  Created by Amine on 2018-07-28.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

protocol TableCompatible {
    
    var height : CGFloat { get }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

