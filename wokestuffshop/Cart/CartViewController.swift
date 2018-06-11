//
//  CartViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Rswift
import Reusable

class CartViewController: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = R.storyboard.cart()
    
    public static func make() -> CartViewController {
        let vc = self.instantiate()
        vc.title = "Cart"
        return vc
    }
    
}
