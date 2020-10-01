//
//  RestaurantDetails.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 27/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation


struct RestaurantDetails: Decodable  {
    let restaurant: RestaurnatDtl
}

struct RestaurnatDtl: Decodable, Identifiable {
    let id: String
    let name, type, logo: String
    let menues: [Menu]
}

struct Menu: Decodable, Identifiable {
    let id: String
    let category, logo, banner: String
    let items: [Item]
}

struct Item: Decodable, Identifiable {
    let id: String
    let name, quantity, logo, banner: String
    let price: Int
}
