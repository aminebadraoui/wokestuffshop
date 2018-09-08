//
//  HomePagerViewController.swift
//  App
//
//  Created by Amine on 2018-08-26.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

class HomePagerViewController: UIPageViewController {

    var browserViewControllers: [HomeBrowserViewController]
    
    let v1 = HomeBrowserViewController()
    let v2 = HomeBrowserViewController()
    let v3 = HomeBrowserViewController()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        browserViewControllers = [v1,v2,v3]
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v1.title = "View Controller 1"
        v2.title = "View Controller 2"
        v3.title = "View Controller 3"
        
        self.delegate = self
        self.dataSource = self
      
        let initialViewController = [browserViewControllers.first!]
        
        setViewControllers(initialViewController, direction: .forward, animated: true, completion: nil)
    }
    
}

extension HomePagerViewController: UIPageViewControllerDelegate {
    
}

extension HomePagerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = browserViewControllers.index(of: viewController as! HomeBrowserViewController)
        
        if currentIndex! > 0 {
            return browserViewControllers[currentIndex!-1]
        }
        
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = browserViewControllers.index(of: viewController as! HomeBrowserViewController)
        
        if currentIndex! < browserViewControllers.count - 1 {
            return browserViewControllers[currentIndex!+1]
        }
        
        return nil 
    }
    
    
}
