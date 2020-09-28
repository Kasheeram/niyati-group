//
//  ContentView.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 19/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var restaurants: [Restaurant] = []

    var body: some View {
        NavigationView {
            List(restaurants) { restaurant in
                NavigationLink(destination: RestaurantDetailsView(restaurant: restaurant)) {
                    PostView(restaurant: restaurant)
                }
            }.navigationBarTitle(Text("Restaurants"))
                .onAppear {
                    Webservices.shared.getGenericData(urlString: "restaurants") { (restaurants: [Restaurant]) in
                        self.restaurants = restaurants
                    }
            }
        }
    }
}

struct PostView: View {
    let restaurant: Restaurant
    var body: some View {
        VStack (alignment: .leading){
            VStack(alignment: .leading, spacing: 4) {
                Text(restaurant.name).font(.headline)
                Text(restaurant.summary).lineLimit(nil).padding(.trailing, 10).fixedSize(horizontal: false, vertical: true)
            }.padding(.leading, 10).padding(.top, 4)
            WebImage(url: URL(string: baseUrl + restaurant.logo))
            .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 150).clipped()
        }.padding(.leading, -20).padding(.bottom, -8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


