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
                viewModel.updateAndSaveAddress()
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(viewModel: viewModel)
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
