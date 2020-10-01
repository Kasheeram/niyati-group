//
//  CartList.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 27/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation


struct CartList: Decodable  {
    let message: String
    let count: Int
    let carts: [Cart]
}

struct Cart: Decodable, Identifiable {
    let cartId, itemId: String
    let name, description, logo, banner: String
    let quantity: Int
    let price: Int
    var id: String {
        return cartId
    }
}
