//
//  ImageViewController.swift
//  App
//
//  Created by Amine on 2018-07-29.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage

class ImageViewController: UIViewController {
    
    var imageURL = URL(fileURLWithPath: "")
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func decodeURL(url: URL) {
        imageURL = url 
        Alamofire.request(url.absoluteString).responseImage { response in
            if let image = response.result.value {
                self.imageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
