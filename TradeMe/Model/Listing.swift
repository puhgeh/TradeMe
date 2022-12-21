//
//  Listing.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

struct Listing: Codable, NameDescribable {
    let id: Int
    let title: String
    let priceDisplay: String
    let buyNowPrice: Decimal?
    let region: String
    let isClassifiied: Bool?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ListingId"
        case title = "Title"
        case priceDisplay = "PriceDisplay"
        case buyNowPrice = "BuyNowPrice"
        case region = "Region"
        case hasBuyNow = "HasBuyNow"
        case isClassified = "IsClassified"
        case imageUrl = "PictureHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        priceDisplay = try values.decode(String.self, forKey: .priceDisplay)
        buyNowPrice = try? values.decode(Decimal.self, forKey: .buyNowPrice)
        region = try values.decode(String.self, forKey: .region)
        isClassifiied = try? values.decode(Bool.self, forKey: .isClassified)
        imageUrl = try? values.decode(String.self, forKey: .imageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(priceDisplay, forKey: .priceDisplay)
            try container.encode(buyNowPrice, forKey: .buyNowPrice)
            try container.encode(region, forKey: .region)
            try container.encode(isClassifiied, forKey: .isClassified)
            try container.encode(imageUrl, forKey: .imageUrl)
        } catch {
            print ("\(typeName): \(error)")
        }
    }
}
