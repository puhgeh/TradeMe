//
//  Stub.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

enum Stub {
    case latest
    
    func data() throws -> Data {
        switch self {
        case .latest:
            return try StubLoader.load(filename: "Listings").data
        }
    }
}

extension URL {
    var data: Data {
        do {
            let data = try Data(contentsOf: self)
            return data
        } catch {
            print(error)
            return Data()
        }
    }
}
