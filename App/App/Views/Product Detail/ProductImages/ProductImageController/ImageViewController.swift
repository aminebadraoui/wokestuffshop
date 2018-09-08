//
//  ImageViewController.swift
//  App
//
//  Created by Amine on 2018-07-29.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ImageViewController: UIViewController {
    
    var imageURL = URL(fileURLWithPath: "")
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func decodeURL(url: URL) {
        imageURL = url
        self.imageView.kf.setImage(with: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(416)
            
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
}
