//
//  LoadingAnimation.swift
//  App
//
//  Created by Amine Badraoui on 2018-09-08.
//  Copyright © 2018 Amine Badraoui. All rights reserved.
//

import UIKit
import SnapKit

class LoadingAnimation {
    static let instance = LoadingAnimation()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect.zero)
        transparentView.backgroundColor = UIColor.clear
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect.zero)
        gifImage.contentMode = .scaleAspectFit
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(asset: "loader_alt")
        return gifImage
    }()
    
    func showLoader(in currentView: UIView) {
        currentView.addSubview(transparentView)
        
        transparentView.snp.makeConstraints({
            if #available(iOS 11.0, *) {
                $0.edges.equalTo(currentView.safeAreaLayoutGuide.snp.edges)
            } else {
                // Fallback on earlier versions
            }
        })
        
        transparentView.addSubview(gifImage)
        gifImage.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        transparentView.bringSubview(toFront: gifImage)
       
    }
    
    func hideLoader() {
        transparentView.removeFromSuperview()
    }
}
