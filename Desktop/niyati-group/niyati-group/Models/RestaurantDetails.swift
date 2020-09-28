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
    let name, logo, banner: String
    let price: Price
}

struct Price: Decodable {
    let price: String
    let half, full, pieces: String
    let one_kg, half_kg, per_plate, per_glass: String
    var prices: String {
        var finalPrice = ""
        if price != "" {
           finalPrice += ", ₹\(price)"
        }
        if half != "" {
           finalPrice += ", Half: ₹\(half)"
        }
        if full != "" {
           finalPrice += ", Full: ₹\(full)"
        }
        if pieces != "" {
           finalPrice += ", Pieces: ₹\(pieces)"
        }
        if one_kg != "" {
           finalPrice += ", One kg: ₹\(one_kg)"
        }
        if half_kg != "" {
           finalPrice += ", Half kg: ₹\(half_kg)"
        }
        if per_plate != "" {
           finalPrice += ", Per plate: ₹\(per_plate)"
        }
        if per_glass != "" {
           finalPrice += ", Per glass: ₹\(per_glass)"
        }
        return String((finalPrice.dropFirst()).dropFirst())
    }
}


