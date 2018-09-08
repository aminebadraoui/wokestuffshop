//
//  HomeSegmentedControlViewModel.swift
//  App
//
//  Created by Amine on 2018-09-03.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeSegmentedControlViewModelInput {
    var indexFromSwipeAction: AnyObserver<Int> { get }
    var segementedControlSelectAction: AnyObserver<Int> { get }
}

protocol HomeSegmentedControlViewModelOutput {
    var segmentedControlSelectedIndex: Observable<Int> { get }
    var selectedIndexFromSwipe: Observable<Int> { get }
}

protocol HomeSegmentedControlViewModelType {
    var input: HomeSegmentedControlViewModelInput { get }
    var output: HomeSegmentedControlViewModelOutput { get }
}

class HomeSegmentedControlViewModel: HomeSegmentedControlViewModelInput,HomeSegmentedControlViewModelOutput, HomeSegmentedControlViewModelType {
    
    let options: [MenuOption]
    
    var disposeBag = DisposeBag()
    
    init(options: [MenuOption]) {
        self.options = options
    }
    
    //  Subjects
    private var _indexFromSwipeActionSubject = PublishSubject<Int>()
    private var _segmentedControlSelectedIndex = PublishSubject<Int>()
   
    
    //  Inputs
    var segementedControlSelectAction: AnyObserver<Int> {
        return _segmentedControlSelectedIndex.asObserver()
    }
    
    var indexFromSwipeAction: AnyObserver<Int> {
        return _indexFromSwipeActionSubject.asObserver()
    }
    
    //  Outputs
    var segmentedControlSelectedIndex: Observable<Int> {
        return _segmentedControlSelectedIndex.asObservable()
    }
    var selectedIndexFromSwipe: Observable<Int> {
        return _indexFromSwipeActionSubject.asObservable()
    }
    
    var input: HomeSegmentedControlViewModelInput { return self }
    var output: HomeSegmentedControlViewModelOutput { return self }
}


