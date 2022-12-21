//
//  StubLoader.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

class StubLoader {
    static let shared = StubLoader()
    
    enum LoaderError: Error {
        case invalidUrl
        case unknown
    }
    
    static func load(filename: String) throws -> URL {
        guard let url = Bundle(for: StubLoader.self).url(forResource: filename, withExtension: "json") else {
            throw LoaderError.invalidUrl
        }
        return url
    }
}
