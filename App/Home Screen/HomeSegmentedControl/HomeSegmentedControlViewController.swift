//
//  HomeSegmentedControlViewController.swift
//  App
//
//  Created by Amine on 2018-09-02.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class HomeSegmentedControlViewController: UIViewController {
    var segmentedControl: UISegmentedControl
    var viewModel: HomeSegmentedControlViewModel
    var homeBtns : [UIButton] = []
    var btnStack: UIStackView
    var selector: UIView
    
    init(viewModel: HomeSegmentedControlViewModel) {
        self.viewModel = viewModel
        segmentedControl = UISegmentedControl(frame: CGRect.zero)
        btnStack = UIStackView(frame: CGRect.zero)
        selector = UIView(frame: CGRect.zero)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStack.axis = .horizontal
        btnStack.distribution = .fillEqually
        
        selector.backgroundColor = .cyan
        
        for i in 0..<viewModel.options.count {
            let menuButton = UIButton(frame: CGRect.zero)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let menuButtonAttributes = [
                NSAttributedStringKey.font : AppFont.customFont(ofSize: AppFont.productNameSize, ofType: .semibold),
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.paragraphStyle : paragraphStyle
            ]
            
            let menuButtonAttributedText = NSAttributedString(string: viewModel.options[i].title, attributes: menuButtonAttributes)
            menuButton.setAttributedTitle(menuButtonAttributedText, for: .normal)
            menuButton.tag = i
            menuButton.backgroundColor = .black
            btnStack.addArrangedSubview(menuButton)
            
            segmentedControl.insertSegment(withTitle: viewModel.options[i].title, at: i, animated: true)
        }
        
        segmentedControl.tintColor = .black
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.borderWidth = 1.5
        segmentedControl.layer.masksToBounds = true
        
        segmentedControl.selectedSegmentIndex = 0
        
        pinSegmentedControl()
        pinSelector()
        
        btnStack.arrangedSubviews.forEach({
            if let button = $0 as? UIButton {
                button.rx.tap.asObservable()
                    .map { _ in button.tag }
                    .do(onNext:{ index in
                        let buttonWidth = self.btnStack.arrangedSubviews[0].bounds.size.width
                        let offset = buttonWidth * CGFloat(integerLiteral: index)
                        
                        UIView.animate(withDuration: 0.2) {
                            self.selector.snp.updateConstraints({
                                $0.left.equalTo(self.btnStack.arrangedSubviews[0].snp.left).offset(offset)
                            })
                            self.selector.superview?.layoutIfNeeded()
                        }
                        })
                    .bind(to: viewModel.input.segementedControlSelectAction)
                    .disposed(by: disposeBag)
            }
        })
        
        viewModel.output.selectedIndexFromSwipe
            .subscribe(onNext: { index in
                let buttonWidth = self.btnStack.arrangedSubviews[0].bounds.size.width
                let offset = buttonWidth * CGFloat(integerLiteral: index)
                
                UIView.animate(withDuration: 0.2) {
                    self.selector.snp.updateConstraints({
                        $0.left.equalTo(self.btnStack.arrangedSubviews[0].snp.left).offset(offset)
                    })
                    self.selector.superview?.layoutIfNeeded()
                }
                
            })
        .disposed(by: disposeBag)
    }
    
    private func pinSegmentedControl() {
        self.view.addSubview(btnStack)
        btnStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func pinSelector() {
        self.view.addSubview(selector)
        selector.snp.makeConstraints({
            $0.height.equalTo(2)
            $0.width.equalTo(btnStack.arrangedSubviews[0].snp.width)
            $0.left.equalTo(btnStack.arrangedSubviews[0].snp.left)
            $0.bottom.equalTo(btnStack.arrangedSubviews[0].snp.bottom)
        })
    }
}
