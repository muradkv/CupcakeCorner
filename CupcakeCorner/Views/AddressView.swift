//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import SwiftUI

struct AddressView: View {
    @Bindable var viewModel: OrderViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.order.address.name)
                TextField("Street Address", text: $viewModel.order.address.streetAddress)
                TextField("City", text: $viewModel.order.address.city)
                TextField("Zip", text: $viewModel.order.address.zip)
            }
            .onChange(of: viewModel.order.address) { oldValue, newValue in
                print("Change")
                viewModel.updateAndSaveAddress()
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: viewModel.order)
                }
            }
            .disabled(viewModel.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(viewModel: OrderViewModel())
}
