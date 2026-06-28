//
//  CupcakeCornerApp.swift
//  CupcakeCorner
//
//  Created by murad on 24.06.2026.
//

import SwiftUI

@main
struct CupcakeCornerApp: App {
    @State private var viewModel = OrderViewModel()
    
    var body: some Scene {
        WindowGroup {
            CupcakeOrderView(viewModel: viewModel)
        }
    }
}
