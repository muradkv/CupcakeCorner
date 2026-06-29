//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var viewModel: OrderViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(viewModel.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await viewModel.placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $viewModel.showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(viewModel.confirmationMessage)
        }
        .alert("Checkout Failed", isPresented: $viewModel.showingError) {
            Button("OK") { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    CheckoutView(viewModel: OrderViewModel())
}
