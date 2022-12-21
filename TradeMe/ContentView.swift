//
//  ContentView.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ListingViewModel
    
    var body: some View {
        TabView {
            LatestListingsView()
                .tabItem {
                    Image("search")
                    Text("Latest Listings")
                }
            WatchlistView()
                .tabItem {
                    Image("watchlist")
                    Text("Watchlist")
                }
            MyTradeMeView()
                .tabItem {
                    Image("profile-16")
                    Text("My Trade Me")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListingViewModel.shared)
    }
}
