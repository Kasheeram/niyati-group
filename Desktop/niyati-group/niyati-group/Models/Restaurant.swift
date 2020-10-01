//
//  Restaurant.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 24/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation
import SwiftUI

struct Restaurant: Decodable, Identifiable {
    let id: String?
    let name, type, summaryDetails ,logo: String?
}
