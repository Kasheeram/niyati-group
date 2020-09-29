//
//  MenuListViewModel.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 29/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


final class MenuListViewModel: ObservableObject {
  
    @Published var menues = [Menu]()
    
    func fetchMenues(id: String) {
        Webservices.shared.getGenericData(urlString: "restaurants/\(id)") { (restaurantDtl: RestaurantDetails?) in
            guard let restaurantDtl = restaurantDtl else { return }
            self.menues = restaurantDtl.restaurant.menues
        }
    }
    
}

struct MenuListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world")
    }
}
