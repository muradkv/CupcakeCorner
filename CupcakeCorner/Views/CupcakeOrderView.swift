//
//  CupcakeOrderView.swift
//  CupcakeCorner
//
//  Created by murad on 24.06.2026.
//

import SwiftUI

struct CupcakeOrderView: View {
    @Bindable var viewModel: OrderViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $viewModel.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(viewModel.order.quantity)", value: $viewModel.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $viewModel.order.specialRequestEnabled)
                    
                    if viewModel.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $viewModel.order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $viewModel.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    CupcakeOrderView(viewModel: OrderViewModel())
}
