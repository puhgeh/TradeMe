//
//  Response.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
    let rawData: Data?
    
    init(value: T, response: URLResponse, rawData: Data? = nil) {
        self.value = value
        self.response = response
        self.rawData = rawData
    }
}

enum ResponseType: String {
    case failure
    case sending
    case success
    case waiting
    case none
}
