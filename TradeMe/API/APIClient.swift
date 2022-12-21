//
//  APIClient.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation
import Combine
import OAuthSwift

struct APIClient {
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    // This is just for the sake of running this sample. Keys should not be stored here
    private static var oauthSwift: OAuthSwift {
        OAuth1Swift(
            consumerKey: "A1AC63F0332A131A78FAC304D007E7D1",
            consumerSecret: "EC7F18B17A062962C6930A8AE88B16C7"
        )
    }
    
    static func run<T: Decodable>(_ request: URLRequest, stub: Data?) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .tryMap { result -> Response in
                if let stub {
                    let value = try decoder.decode(T.self, from: stub)
                    return Response(value: value, response: result.response, rawData: stub)
                }
                
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIError.apiError(reason: "Unable to process HTTP response")
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    let message = String(decoding: result.data, as: UTF8.self)
                    throw APIError.apiError(reason: message)
                }
                
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response, rawData: result.data)
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.unknown(reason: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func oauth(url: URL, completionHandler completion: OAuthSwiftHTTPRequest.CompletionHandler?) {
        oauthSwift.client.get(url, completionHandler: completion)
    }
}
