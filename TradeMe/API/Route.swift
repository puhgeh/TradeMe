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

        // TODO: keys should not be defined here
        var request = URLRequest(url: url)
        request.httpMethod = self.path.method.toString()
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("OAuth", forHTTPHeaderField: "Authorization")
        request.setValue("1.0", forHTTPHeaderField: "oauth_version")
        request.setValue("PLAINTEXT", forHTTPHeaderField: "oauth_signature_method")
        request.setValue("A1AC63F0332A131A78FAC304D007E7D1", forHTTPHeaderField: "oauth_consumer_key")
        request.setValue("EC7F18B17A062962C6930A8AE88B16C7", forHTTPHeaderField: "oauth_signature")
        

        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
}
