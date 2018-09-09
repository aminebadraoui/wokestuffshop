//
//  LoadingAnimation.swift
//  App
//
//  Created by Amine Badraoui on 2018-09-08.
//  Copyright © 2018 Amine Badraoui. All rights reserved.
//

import UIKit

class LoadingAnimation: UIView {
    static let instance = LoadingAnimation()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.clear
        //transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(asset: "loader_alt")
        return gifImage
    }()
    
    func showLoader() {
        self.addSubview(transparentView)
        self.transparentView.addSubview(gifImage)
        self.transparentView.bringSubview(toFront: gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    func hideLoader() {
        self.transparentView.removeFromSuperview()
    }
}
