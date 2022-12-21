//
//  ListingView.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

struct ListingView: View {
    @Binding var listing: Listing
    
    init(listing: Listing) {
        _listing = Binding.constant(listing)
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: listing.imageUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(5)
            .clipped()
            .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(listing.region)
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Text(listing.title)
                    .foregroundColor(.black)
                    .bold()
                    .lineLimit(2)
                    .font(.subheadline)
                
                Spacer()

                HStack(alignment: .bottom) {
                    Text(listing.priceDisplay)
                        .bold()
                        .font(.subheadline)
                    
                    Spacer()
                    
                    if let buyNow = listing.buyNowPrice, buyNow > 0 {
                        Text(listing.buyNowPrice ?? 0.0, format: .currency(code: "USD"))
                            .bold()
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}
