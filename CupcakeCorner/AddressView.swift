//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let order = Order()
    AddressView(order: order)
}
