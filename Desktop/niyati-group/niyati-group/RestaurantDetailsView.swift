//
//  RestaurantDetailsView.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 20/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantDetailsView: View {
    var restaurant: Restaurant
    
    @State var menues: [Menu] = []
    
    var body: some View {
        List {
            ForEach(menues) { menu in
                Section(header: Text(menu.category).font(.headline)) {
                ForEach(menu.items) { item in
                    ItemView(item: item)
                }
               }
            }
        }.listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Menu"))
        .onAppear {
            Webservices.shared.getGenericData(urlString: "restaurants/\(self.restaurant.id)") { (restaurantDtl: RestaurantDetails?) in
                    guard let restaurantDtl = restaurantDtl else { return }
                    self.menues = restaurantDtl.restaurant.menues
                }
        }
        
    }
}

struct ItemView: View {
    let item: Item
    
    var body: some View {
        HStack {
            WebImage(url: URL(string:(baseUrl + item.logo))).resizable().placeholder(Image(systemName: "post_puppy")).indicator(.activity).frame(width: 50, height: 50, alignment: .center).clipped()
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.price.prices)
            }
            Spacer()
            Button(action: {
                self.addToCard()
            }){
                Text("Add +").frame(width: 80, height: 30).overlay(
                    RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 1)
                )
            }
            
        }
    }
    
    func addToCard() {
        print("Button clicked")
    }
}

let restaurant = Restaurant(id: "12", name: "AFZAL CHICKEN", type: "NON VEG", summary: "sdkfjl sdlfkj sdfkfhk fsdkjf fsdkfjhk", logo: "post_puppy")

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailsView(restaurant: restaurant)
    }
}


