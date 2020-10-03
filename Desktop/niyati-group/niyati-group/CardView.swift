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
                self.placeOrder(items: self.cartListVM.cartList)
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
    
    func placeOrder(items: [Cart]) {
        let items = items
        var totalTtems = 0
        var grandTotal = 0
        var itemsDic = [[String: AnyObject]]()
        for item in items {
            let cost = item.quantity * item.price
            var locDic = [String: AnyObject]()
            locDic["itemId"] = item.id as AnyObject
            locDic["quantity"] = item.quantity as AnyObject
            locDic["cost"] = cost as AnyObject
            totalTtems += item.quantity
            grandTotal += cost
            itemsDic.append(locDic)
        }
        
        let params = ["items": itemsDic, "total_items": totalTtems, "grand_total": grandTotal] as [String : AnyObject]
        
        let url = "orders/5f71aded1110e60bbeac7973"
        Webservices.shared.postGenericData(urlString: url, params: params) { (res: Swift.Result<statusCode, Error>)  in
            // stopProgressActivity()
            switch res {
            case .success(let checkStatus):
                print(checkStatus.status as Any)
            case .failure(let err):
                print(err)
                // self.handleFailureControl(err: err)
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
