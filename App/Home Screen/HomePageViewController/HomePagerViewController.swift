//
//  HomePagerViewController.swift
//  App
//
//  Created by Amine on 2018-08-26.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit

class HomePagerViewController: UIPageViewController {
    var browserViewControllers: [HomeBrowserViewController] = []
    
    var viewModel: HomePagerViewModel
    var currentController: HomeBrowserViewController!
    
    init(viewModel: HomePagerViewModel) {
        self.viewModel = viewModel
        browserViewControllers = viewModel.outputs.homeBrowsers

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.currentController = browserViewControllers.first!
        let initialViewController = [browserViewControllers.first!]
        
        self.setViewControllers(initialViewController, direction: .forward, animated: true, completion: nil)

        
        viewModel.outputs.swipedFromHeader
            .subscribe(onNext: { index in
                let viewController = [self.browserViewControllers[index]]
                
                let currentIndex = self.browserViewControllers.index(of: self.currentController)
                
                
                if index > currentIndex! {
                    self.setViewControllers(viewController, direction: .forward, animated: true, completion: nil)
                }
                else {
                    self.setViewControllers(viewController, direction: .reverse, animated: true, completion: nil)
                }
                
            }).disposed(by: disposeBag)
    }
    
}

extension HomePagerViewController: UIPageViewControllerDelegate {
    
}

extension HomePagerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentController = viewController as! HomeBrowserViewController
        let currentIndex = browserViewControllers.index(of: viewController as! HomeBrowserViewController)
        viewModel.inputs.swipeAction.onNext(currentIndex!)
        if currentIndex! > 0 {
            
            return browserViewControllers[currentIndex!-1]
        }
        
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentController = viewController as! HomeBrowserViewController
        
        let currentIndex = browserViewControllers.index(of: viewController as! HomeBrowserViewController)
        viewModel.inputs.swipeAction.onNext(currentIndex!)
        if currentIndex! < browserViewControllers.count - 1 {
            
            return browserViewControllers[currentIndex!+1]
        }
        
        return nil 
    }
}
