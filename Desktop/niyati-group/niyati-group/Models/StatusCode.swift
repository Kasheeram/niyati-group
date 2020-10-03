//
//  StatusCode.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 02/10/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation


struct statusCode: Decodable {
    let status: String? = "success"
    let message: String?
}
