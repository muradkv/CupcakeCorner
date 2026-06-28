//
//  Order.swift
//  CupcakeCorner
//
//  Created by murad on 25.06.2026.
//

import Foundation

struct Order: Codable {
    // MARK: - Type Constants
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

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
    
    var address = Address()
        
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
}
