//
//  ProductDetailViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Rswift
import Reusable
import RxSwift


class ProductDetailViewController: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = R.storyboard.productDetailViewController()
    
    public static func make() -> ProductDetailViewController {
        let vc = self.instantiate()
       // vc.title = "Product"
        return vc
    }
    
    @IBOutlet weak var productBtn: UIButton!
    
    var showCart = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        productBtn.addTarget(self, action: #selector(testBtn), for: .touchUpInside)
        
    }
    
    @objc func testBtn() {
        showCart.onNext(true)
        
        print("btn pressed")
    }
    
}
