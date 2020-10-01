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
    
    @ObservedObject var menuVM = MenuListViewModel()
    @State var isPresentingCardView = false
    
    @State var numberOfCardItems = 0
    
    var body: some View {
        List {
            ForEach(menuVM.menues) { menu in
                Section(header: Text(menu.category ?? "").font(.headline)) {
                    ForEach(menu.items ?? []) { item in
                        ItemView(item: item, numberOfCardItems: self.$numberOfCardItems)
                    }
                }
            }
        }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Menu"))
            .navigationBarItems(trailing:
                NavigationLink(destination: CardView(), isActive: $isPresentingCardView) {
                    CustomNavButton(numberOfCardItems: $numberOfCardItems, isPresentingCardView: self.$isPresentingCardView)
                }
        )
        .onAppear {
            if self.menuVM.menues.count < 1 {
                guard let id = self.restaurant.id else { return }
                self.menuVM.fetchMenues(id: id)
            }
        }
        
    }
}

struct CustomNavButton: View {
    @Binding var numberOfCardItems: Int
    @Binding var isPresentingCardView: Bool
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isPresentingCardView.toggle()
            }) {
                Image("shopping-cart").resizable().frame(width: 25, height: 25)
            }
            .foregroundColor(Color.black)
            if numberOfCardItems != 0 {
                Text("\(numberOfCardItems)").font(.caption).padding(5).background(Color.red).clipShape(Circle()).foregroundColor(Color.white).offset(x: 10, y: -10)
            }
        }.animation(.spring())
    }
}


struct ItemView: View {
    let item: Item
    @Binding var numberOfCardItems: Int
    var body: some View {
        HStack {
            WebImage(url: URL(string:(baseUrl + (item.logo ?? "")!))).resizable().placeholder(Image("burger")).indicator(.activity).frame(width: 50, height: 50, alignment: .center).clipped()
            VStack(alignment: .leading) {
                Text(item.name ?? "")
                Text("\(item.quantity ?? ""): ₹\(item.price ?? 0)")
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
        print("Add item to card")
        self.numberOfCardItems += 1
    }
}

//let restaurant = Restaurant(id: "12", name: "AFZAL CHICKEN", type: "NON VEG", summaryDetails: "sdkfjl sdlfkj sdfkfhk fsdkjf fsdkfjhk", logo: "post_puppy")

//struct RestaurantDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetailsView(restaurant: restaurant)
//    }
//}


