//
//  LatestListingsView.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

struct LatestListingsView: View {
    @EnvironmentObject private var viewModel: ListingViewModel
    @State private var searchText = ""
    @State private var showingSearch = false
    @State private var showingCart = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.listings, id: \.id) { listing in
                    NavigationLink {
                        ListingDetailView()
                    } label: {
                        ListingView(listing: listing)
                    }
                }
            }
            .refreshable {
                viewModel.loadOAuth()
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showingSearch = true
                        } label: {
                            Image("search")
                        }
                        .alert("Search", isPresented: $showingSearch) {
                                Button("OK", role: .cancel) {}
                            }
                        Button {
                            showingCart = true
                        } label: {
                            Image("cart")
                        }
                        .alert("Add to cart", isPresented: $showingCart) {
                                Button("OK", role: .cancel) {}
                            }
                    }
                }
            }
        }
    }
}

struct LatestListingsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestListingsView()
    }
}
