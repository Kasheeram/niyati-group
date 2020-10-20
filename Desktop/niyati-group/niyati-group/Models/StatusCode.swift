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


struct UserDetail: Decodable {
    let message: String?
    let token: String?
}


class NiyatiApp {
    
    static let shared = NiyatiApp()
    
    let message: String? = nil
    var token: String? = nil
    
    var isTokenRefesh = false {
        didSet {
            UserDefaults.standard.set(isTokenRefesh, forKey: "isTokenRefesh")
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveAppDetails(user: UserDetail) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(user.token, forKey: "accessToken")
    }
    
    func getAppDetails() {
       let userDefaults = UserDefaults.standard
        token = userDefaults.string(forKey: "accessToken")
    }
}
