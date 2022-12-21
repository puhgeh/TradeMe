//
//  ListingViewModel.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import Foundation
import Combine

class ListingViewModel: ObservableObject {
    @Published var listings: [Listing] = []
    
    static let shared = ListingViewModel()
    private let service = ListingService.shared
    private var cancellables = Set<AnyCancellable>()
    private var request: AnyCancellable? = nil
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    init() {
        loadOAuth()
    }
    
    func load() {
        request = try? service.latest(stub: false)
            .map(\.value)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("failed: \(error.localizedDescription)")
                case .finished:
                    print(completion)
                }
            }, receiveValue: { [weak self] latest in
                self?.listings = latest.list
            })
        
        request?.store(in: &cancellables)
    }
    
    func loadOAuth() {
        do {
            try service.latestOAuth { [weak self] result in
                switch result {
                    case .success(let response):
                    let latest = try? self?.decoder.decode(Latest.self, from: response.data)
                    self?.listings = latest?.list ?? []
                    case .failure:
                    self?.listings.removeAll()
                }
            }
        } catch {
            listings.removeAll()
        }
    }
    
    deinit {
        cancellables.removeAll()
    }
}
