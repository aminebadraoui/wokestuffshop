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

class CartViewController: UIViewController, StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = R.storyboard.cart()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    @IBAction func CheckoutAction(_ sender: Any) {
        checkout()
    }
    
    public static func make() -> CartViewController {
        let vc = self.instantiate()
        vc.title = "Cart"
        return vc
    }
    
    override func viewDidLoad() {
        configureTableView()
        
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
        return CartManager.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CartCell.self)
        return cell
    }
}


