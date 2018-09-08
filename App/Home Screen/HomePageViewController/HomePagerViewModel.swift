//
//  HomePagerViewModel.swift
//  App
//
//  Created by Amine on 2018-08-26.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePagerViewModelInput {

    var changeIndexFromHeader: AnyObserver<Int> { get }
    var swipeAction: AnyObserver<Int> { get }
}

protocol HomePagerViewModelOutput {
    var homeBrowsers: [HomeBrowserViewController] { get }
    var swipedFromHeader: Observable<Int> { get }
    var swipedToIndex: Observable<Int> { get }
}

protocol HomePagerType {
    var inputs: HomePagerViewModelInput { get }
    var outputs: HomePagerViewModelOutput { get }
}

var disposeBag = DisposeBag()

class HomePagerViewModel: HomePagerViewModelInput, HomePagerViewModelOutput, HomePagerType {
    var options: [MenuOption]
    
    init(options: [MenuOption]) {
        self.options = options
        homeBrowsers = options.map {
            let homeBrowserViewModel = HomeBrowserViewModel(option: $0)
            let homeBrowser = HomeBrowserViewController(vm: homeBrowserViewModel)
            homeBrowser.title = $0.title
            return homeBrowser
        }
    }
    
    //  Subjects
    private var _changeIndexFromHeaderSubject = PublishSubject<Int>()
    private var _swipeActionSubject = PublishSubject<Int>()
    
    //  Inputs
    var changeIndexFromHeader: AnyObserver<Int> {
        return _changeIndexFromHeaderSubject.asObserver()
    }
    var swipeAction: AnyObserver<Int> {
         return _swipeActionSubject.asObserver()
    }
    //  Outputs
    var homeBrowsers: [HomeBrowserViewController]
    var swipedFromHeader: Observable<Int> {
        return _changeIndexFromHeaderSubject.asObservable()
    }
    var swipedToIndex: Observable<Int>{
        return _swipeActionSubject.asObservable()
    }
    
    var inputs: HomePagerViewModelInput { return self }
    var outputs: HomePagerViewModelOutput { return self }
}
