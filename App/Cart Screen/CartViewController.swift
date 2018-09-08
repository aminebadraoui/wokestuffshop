//
//  CartViewController.swift
//  wokestuffshop
//
//  Created by Amine on 2018-06-05.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import UIKit
import Rswift
import Reusable
import MobileBuySDK
import ShopifyKit
import SafariServices
import RxSwift
import RxCocoa

class CartViewController: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = R.storyboard.cart()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!
    
    var viewModel: CartViewModel!
    var disposeBag = DisposeBag()
    
    @IBAction func CheckoutAction(_ sender: Any) {
        checkout()
    }
    
    public static func make(viewModel: CartViewModel) -> CartViewController {
        let vc = self.instantiate()
        vc.title = "Cart"
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        configureTableView()
        
        viewModel.outputs.reloadView.subscribe(onNext: {
            self.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.outputs.subtotalObservable
            .map { Currency.stringFrom($0) }
            .asDriver(onErrorJustReturn: "0.0")
            .drive(subTotal.rx.text)
            .disposed(by: disposeBag)
        
       viewModel.outputs.checkoutBtnEnabled
        .asDriver(onErrorJustReturn: false)
        .drive(checkoutBtn.rx.isEnabled)
        .disposed(by: disposeBag)
        
        viewModel.outputs.checkoutBtnEnabled
            .subscribe(onNext: { isEnabled in
                if isEnabled {
                self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.5176470588, blue: 0.05098039216, alpha: 1)
                }
                else {
                    self.checkoutBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
                
            })
        .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.register(cellType: CartCell.self)
        
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func checkout() {
        let cartItems = CartManager.shared.items
        Client.shared.createCheckout(with: cartItems) { checkout in
            guard let checkout = checkout else {
                print("Failed to create checkout.")
                return
            }
                    self.openSafariFor(checkout)
            }
        
}
    
    func openSafariFor(_ checkout: CheckoutModel) {
        let safari                  = SFSafariViewController(url: checkout.webURL)
        safari.navigationItem.title = "Checkout"
        self.navigationController?.present(safari, animated: true, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(viewModel.items.count)")
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CartCell.self)
        let row = viewModel.items[indexPath.row]
        cell.configure(row: row)
        
       row.outputs.tappedStepper
        .map { stepperValue in
            (stepperValue, indexPath) }
        .bind(to: viewModel.inputs.updateQuantityAction)
        .disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            tableView.beginUpdates()
            
            viewModel.inputs.removeItemAction.onNext(indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        default:
            break
        }
    }
}


