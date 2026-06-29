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
                
                Button {
                    Task {
                        await viewModel.placeOrder()
                    }
                } label: {
                    if viewModel.isSubmitting {
                        HStack {
                            ProgressView()
                            Text("Placing Order...")
                        }
                    } else {
                        Text("Place Order")
                    }
                }
                .padding()
                .disabled(viewModel.isSubmitting)
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
