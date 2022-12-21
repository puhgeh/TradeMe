//
//  Latest.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

struct Latest: Codable, NameDescribable {
    let totalCount: Int
    let page: Int
    let pageSize: Int
    let list: [Listing]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case page = "Page"
        case pageSize = "PageSize"
        case list = "List"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        page = try values.decode(Int.self, forKey: .page)
        pageSize = try values.decode(Int.self, forKey: .pageSize)
        list = try values.decode([Listing].self, forKey: .list)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(totalCount, forKey: .totalCount)
            try container.encode(page, forKey: .page)
            try container.encode(pageSize, forKey: .pageSize)
            try container.encode(list, forKey: .list)
        } catch {
            print ("\(typeName): \(error)")
        }
    }
}
