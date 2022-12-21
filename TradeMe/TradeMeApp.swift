//
//  TradeMeApp.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

@main
struct TradeMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ListingViewModel.shared)
        }
    }
}
