//
//  CollectionViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import  UIKit
import Reusable
import Rswift
import RxSwift

class CollectionViewController: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = R.storyboard.collection()
    var didTap = PublishSubject<Bool>()
    
    @IBOutlet weak var productBtn: UIButton!
    
    public static func make() -> CollectionViewController {
        let vc =  self.instantiate()
        vc.title = "Collections"
        return vc
    }
    
    override func viewDidLoad() {
        productBtn.addTarget(self, action: #selector(testBtn), for: .touchUpInside)
    }
    
    @objc func testBtn() {
      didTap.onNext(true)
        
        print("btn pressed")
    }
}
