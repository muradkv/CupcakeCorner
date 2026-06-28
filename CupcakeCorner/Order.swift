//
//  Order.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import SwiftUI

@Observable
final class Order: Codable {
    // MARK: - Type Constants
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // MARK: - Private Constants
    private let addressKey = "SavedAddressProfile"

    // MARK: - Stored Properties (Basket)
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    // MARK: - Stored Properties (Delivery)
    var address = Address() {
        didSet {
            saveAddressToDisk()
        }
    }
    
    // MARK: - Initialization
    init() {
        loadAddressFromDisk()
    }
    
    // MARK: - Computed Properties
    var hasValidAddress: Bool {
        let trimmedName = address.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedStreetAddress = address.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCity = address.city.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedZip = address.zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty || trimmedStreetAddress.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        }

        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    // MARK: - Private Disk Storage Methods
    private func saveAddressToDisk() {
        do {
            let data = try JSONEncoder().encode(address)
            UserDefaults.standard.set(data, forKey: addressKey)
        } catch {
            print("Failed to save address to disk: \(error.localizedDescription)")
        }
    }
    
    private func loadAddressFromDisk() {
        guard let savedData = UserDefaults.standard.data(forKey: addressKey) else { return }
        
        do {
            let decodedAddress = try JSONDecoder().decode(Address.self, from: savedData)
            self.address = decodedAddress
        } catch {
            print("Failed to load and decode address: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Codable Mapping
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _address = "address"
    }
}
