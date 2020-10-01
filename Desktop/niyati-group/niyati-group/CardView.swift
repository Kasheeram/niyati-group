//
//  CardView.swift
//  niyati-group
//
//  Created by Kashee Kushwaha on 28/09/20.
//  Copyright © 2020 Kashee Kushwaha. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    @ObservedObject var cartListVM = CartListViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(footer: FooterView(items: cartListVM.cartList)) {
                    ForEach(cartListVM.cartList) { cartItem in
                        CartItemView(item: cartItem)
                    }
                }
            }.listStyle(GroupedListStyle())
            Button(action: {
                print("Do something on click of order now button")
            }) {
                Text("Order Now").frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .font(.headline)
            }
        }
        .navigationBarTitle(Text("Cart"))
        .onAppear {
            if self.cartListVM.cartList.count < 1 {
                self.cartListVM.fetchCarts(id: "")
            }
        }
    }
}

struct FooterView: View {
    let items: [Cart]
    var body: some View {
        HStack {
            Text("Grand total").font(.headline).foregroundColor(Color.black)
            Spacer()
            Text("₹\(calculatAmount())").font(.headline).foregroundColor(Color.black)
        }.frame(height: 50)
    }
    
    func calculatAmount() -> Int {
        var totalAmount = 0
        for item in items {
            totalAmount += (item.price * item.quantity)
        }
        return totalAmount
    }
}


struct CartItemView: View {
    let item: Cart
    var body: some View {
        HStack {
            WebImage(url: URL(string:(baseUrl + item.logo))).resizable().placeholder(Image("burger")).indicator(.activity).frame(width: 60, height: 60, alignment: .center).clipped()
            VStack(alignment: .leading) {
                Text(item.name)
                Text("\(item.description): ₹\(item.price)").padding(.top, 8)
            }
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Button(action: {
                        print("Minus button clicked")
                    }){
                        Text("-").font(.system(size: 22, weight: .bold)).foregroundColor(Color.red.opacity(0.8))
                    }.buttonStyle(BorderlessButtonStyle())
                    Text("\(item.quantity)").frame(width: 30, height: 33).background(Color.red.opacity(0.2))
                    Button(action: {
                        print("Plus button clicked")
                    }){
                        Text("+").font(.system(size: 20, weight: .bold)).foregroundColor(Color.red.opacity(0.8))
                    }.buttonStyle(BorderlessButtonStyle())
                }.frame(width: 100, height: 35).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                
                Text("₹\(item.quantity * item.price)").padding(.top, 8)
            }
            
        }.padding(.top, 4).padding(.bottom, 4)
    }
}
