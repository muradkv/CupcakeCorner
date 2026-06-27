//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var order: Order
    
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
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Checkout Failed", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        //Old not working
        //let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        }  catch let decodingError as DecodingError {
            switch decodingError {
            case .keyNotFound(let key, _):
                print("Decoding Error: Key '\(key.stringValue)' is missing in server JSON.")
            case .valueNotFound(let type, _):
                print("Decoding Error: Value for type '\(type)' is empty/null.")
            case .typeMismatch(let type, _):
                print("Decoding Error: Wrong data type. Expected '\(type)'.")
            case .dataCorrupted(_):
                print("Decoding Error: Broken JSON syntax.")
            default:
                print("Decoding Error: Unknown sorting issue.")
            }
            
            errorMessage = "We had trouble parsing the order details from the server. Please try again."
            showingError = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            
            errorMessage = "Connection error. Please try again."
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
