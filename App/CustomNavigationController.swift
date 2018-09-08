//
//  CustomNavigationController.swift
//  App
//
//  Created by Amine on 2018-07-25.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//
import UIKit

class CustomNavigationController: UINavigationController {


    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.barTintColor = .black
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
