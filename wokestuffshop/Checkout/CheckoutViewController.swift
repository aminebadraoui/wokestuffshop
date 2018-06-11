//
//  CheckoutViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Rswift
import Reusable
import RxSwift

class CheckoutViewController: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = R.storyboard.checkout()
    
    public static func make() -> CheckoutViewController {
      let vc = self.instantiate()
        vc.title = "Checkout"
        return vc
    }
    
    
}
