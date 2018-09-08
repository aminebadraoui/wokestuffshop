//
//  HomeViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//


import ShopifyKit
import MobileBuySDK
import RxSwift
import SnapKit

class HomeViewController: UIViewController {
    let client = Client.shared
    
    let disposeBag = DisposeBag()
    
    //  Properties
    var viewModel: HomeViewModel!
    var segmentedControl: HomeSegmentedControlViewController
    var pager: HomePagerViewController
    
    var navBarSize: CGFloat = 0.0
    
    init (vm: HomeViewModel) {
        self.viewModel = vm
        
        let segementedControlViewModel = HomeSegmentedControlViewModel(options: viewModel.outputs.menuOptions)
        segmentedControl = HomeSegmentedControlViewController(viewModel: segementedControlViewModel)
        
        let pagerViewModel = HomePagerViewModel(options: viewModel.outputs.menuOptions)
        pager = HomePagerViewController(viewModel: pagerViewModel)
        
        super.init(nibName: nil, bundle: nil)
        
        segementedControlViewModel.output.segmentedControlSelectedIndex
        .bind(to: pagerViewModel.inputs.changeIndexFromHeader)
        .disposed(by: disposeBag)

        pagerViewModel.outputs.swipedToIndex
        .bind(to: segementedControlViewModel.input.indexFromSwipeAction)
        .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setup()
        PinSegmentedControl()
        PinPager()
    }
    
    private func PinSegmentedControl() {
        self.view.addSubview(segmentedControl.view)
        //self.view.safeAreaInsets
        segmentedControl.view.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(36)
        })
    }
    
    private func PinPager() {
        self.view.addSubview(pager.view)
        pager.view.snp.makeConstraints({
            $0.top.equalTo(segmentedControl.view.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    func setup() {

        //  Setup of the navigation item
        self.navigationItem.titleView =  UIImageView(image: #imageLiteral(resourceName: "logo_wokestuff"))
        
        //  Setup of the background view
        self.view.backgroundColor = AppColor.appBackground
    }
}




