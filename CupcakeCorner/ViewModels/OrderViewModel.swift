//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by murad on 28.06.2026.
//

import SwiftUI

@Observable
final class OrderViewModel {
    var order = Order()
    
    var confirmationMessage = ""
    var showingConfirmation = false
    var errorMessage = ""
    var showingError = false
    var isSubmitting = false
    
    private let addressKey = "SavedAddressProfile"
    
    init() {
        loadAddressFromDisk()
    }
    
    func placeOrder() async {
        isSubmitting = true
        
        defer {
            isSubmitting = false
        }
        
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
    
    func updateAndSaveAddress() {
        do {
            let data = try JSONEncoder().encode(order.address)
            UserDefaults.standard.set(data, forKey: addressKey)
        } catch {
            print("Failed to save address to disk: \(error.localizedDescription)")
        }
    }
    
    private func loadAddressFromDisk() {
        guard let savedData = UserDefaults.standard.data(forKey: addressKey) else { return }
        
        do {
            let decodedAddress = try JSONDecoder().decode(Address.self, from: savedData)
            self.order.address = decodedAddress
        } catch {
            print("Failed to load and decode address: \(error.localizedDescription)")
        }
    }
}
