//
//  WatchlistView.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

struct WatchlistView: View {
    var body: some View {
        NavigationView {
            Color.blue
                .navigationTitle("Watchlist")
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea()
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView()
    }
}
