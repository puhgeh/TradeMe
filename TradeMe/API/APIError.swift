//
//  APIError.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown(reason: String), apiError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown(let reason):
            return reason
        case .apiError(let reason):
            return reason
        }
    }
}
