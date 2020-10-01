//
//  CartListViewModel.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 29/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation
import Combine

final class CartListViewModel: ObservableObject {
  
    @Published var cartList = [Cart]()
    
    func fetchCarts(id: String) {
        Webservices.shared.getGenericData(urlString: "carts") { (carts: CartList?) in
            guard let carts = carts else { return }
            self.cartList = carts.carts
        }
    }
    
}
