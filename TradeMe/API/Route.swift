//
//  Route.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case put
    case delete
    
    func toString() -> String {
        return String(describing: self).uppercased()
    }
}

enum Route {
    case latest
    case watchlist
    case myTradeMe
    
    var baseUrl: URL? {
        URL(string: "https://api.tmsandbox.co.nz/v1/")
    }
    
    var path: (string: String, method: HTTPMethod) {
        switch self {
        case .latest:
            return ("listings/latest.json", .get)
        default:
            return ("", .get)
        }
    }

    func request(body: Data? = nil) throws -> URLRequest {
        guard let baseUrl = baseUrl,
              let components = URLComponents(url: baseUrl.appendingPathComponent(self.path.string), resolvingAgainstBaseURL: true),
              let url = components.url else {
            throw APIError.apiError(reason: "Unable to construct URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.path.method.toString()

        if let body = body {
            request.httpBody = body
        }
        
        return request
        
    }
    
    func url() throws -> URL {
        guard let baseUrl = baseUrl,
              let components = URLComponents(url: baseUrl.appendingPathComponent(self.path.string), resolvingAgainstBaseURL: true),
              let url = components.url else {
            throw APIError.apiError(reason: "Unable to construct URL")
        }

        return url
    }
}
