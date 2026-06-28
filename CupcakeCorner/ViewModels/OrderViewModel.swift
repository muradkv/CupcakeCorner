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
    
    private let addressKey = "SavedAddressProfile"
    
    init() {
        loadAddressFromDisk()
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
