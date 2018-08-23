//
//  ImagesPageViewController.swift
//  App
//
//  Created by Amine on 2018-07-29.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import ShopifyKit
class ImagesPageViewController: UIPageViewController,
    UIPageViewControllerDataSource,
UIPageViewControllerDelegate{
    
    var imageViewControllers: [ImageViewController] = []
    var imagesUrls = [URL]()
    var pageControl = UIPageControl()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        dataSource = self
        delegate   = self
        
        configurePageControl()
        
        imageViewControllers = imagesUrls.map  {
            let imageController = ImageViewController()
            imageController.decodeURL(url: $0)
            return imageController
        }
        
        let initialViewController = [imageViewControllers.first!]
        
        setViewControllers(initialViewController, direction: .forward, animated: true, completion: nil)
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY, width: UIScreen.main.bounds.width, height: 20))
        
        self.pageControl.numberOfPages = imagesUrls.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        
        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    /********************************************/
    // Datasource functions
    
    //  Forward direction
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageUrl = (viewController as! ImageViewController).imageURL
        let currentIndex = imagesUrls.index(of: currentImageUrl)
        
        if currentIndex! < self.imagesUrls.count - 1 {
            let nextImageViewController = ImageViewController()
            nextImageViewController.decodeURL(url: imagesUrls[currentIndex!+1])
            return nextImageViewController
        }
        return nil
    }
    
    //  Backward direction
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentImageUrl = (viewController as! ImageViewController).imageURL
        let currentIndex = imagesUrls.index(of: currentImageUrl)
        
        if currentIndex! > 0 {
            let nextImageViewController = ImageViewController()
            nextImageViewController.decodeURL(url: imagesUrls[currentIndex! - 1])
            return nextImageViewController
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            let currentImageUrl = (viewControllers[0] as! ImageViewController).imageURL
            
            let currentIndex = imagesUrls.index(of: currentImageUrl)
            
            self.pageControl.currentPage = currentIndex!
        }
    }
    
}
