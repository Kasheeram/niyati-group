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
    
    init() {
        // To remove only extra separators below the list:
        // UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        // To set cell background color
        // UITableViewCell.appearance().backgroundColor = .gray
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List(restaurants) { restaurant in
                ZStack {
                    PostView(restaurant: restaurant)
                    NavigationLink(destination: RestaurantDetailsView(restaurant: restaurant)) {
                        EmptyView() // All this drama has been done to remove right arrow
                    }
                }
            }
            .navigationBarTitle(Text(NavTitles.restaurants))
            .onAppear {
                Webservices.shared.getGenericData(urlString: AppUrls.restaurantsList) { (restaurants: [Restaurant]) in
                    self.restaurants = restaurants
                    print(restaurants[0].summaryDetails)
                }
                
            }
        }
    }
}


struct PostView: View {
    let restaurant: Restaurant?
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(restaurant?.name ?? "").font(.headline)
                    Text(restaurant?.summaryDetails ?? "").lineLimit(nil).fixedSize(horizontal: false, vertical: true)
                }
                .layoutPriority(100)
                Spacer()
            }.padding([.top, .leading])
            
            WebImage(url: URL(string: baseUrl + (restaurant?.logo ?? "")!))
                .resizable().frame(height: 150, alignment: .center).clipped()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white.opacity(1.0))
        .modifier(CardModifier())
        .padding(.top, 20)
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 0)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


