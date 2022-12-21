//
//  ListingService.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation
import Combine
import OAuthSwift

class ListingService {
    static let shared = ListingService()
    private var cancellables: Set<AnyCancellable> = []
    
    func latest(stub: Bool = false) throws -> AnyPublisher<Response<Latest>, Error> {
        do {
            let request = try Route.latest.request()
            let payload: Data? = stub ? data() : nil
            return (APIClient.run(request, stub: payload) as AnyPublisher<Response<Latest>, Error>)
        } catch {
            throw APIError.apiError(reason: error.localizedDescription)
        }
    }
    
    func latestOAuth(completion: OAuthSwiftHTTPRequest.CompletionHandler?) throws {
        do {
            let url = try Route.latest.url()
            APIClient.oauth(url: url, completionHandler: completion)
        } catch {
            throw APIError.apiError(reason: error.localizedDescription)
        }
    }
    
    private func data() -> Data? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? Stub.latest.data()
    }

    deinit {
        cancellables.removeAll()
    }
}
